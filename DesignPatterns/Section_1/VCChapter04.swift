//
//  VCChapter04.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/23/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit
import PromiseKit

// A delay function
func delay(seconds: Double, completion: @escaping ()-> Void) {
	DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class VCChapter04: BaseViewControllerSection01 {
	// MARK: IB Outlets
	@IBOutlet var bgImageView: UIImageView!
	
	@IBOutlet var summaryIcon: UIImageView!
	@IBOutlet var summary: UILabel!
	
	@IBOutlet var flightNr: UILabel!
	@IBOutlet var gateNr: UILabel!
	@IBOutlet var departingFrom: UILabel!
	@IBOutlet var arrivingTo: UILabel!
	@IBOutlet var planeImage: UIImageView!
	
	@IBOutlet var flightStatus: UILabel!
	@IBOutlet var statusBanner: UIImageView!
	
	private var snowView: SnowView!
	
	// MARK: View life cycles
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
}

// Animation actions
private extension VCChapter04 {
	func fade(imageView: UIImageView, toImage: UIImage, showEffects: Bool) -> Promise<Bool> {
		return Promise { seal in
			// Cross image view to new image
			UIView.transition(.promise,
							  with: imageView,
							  duration: 1.0,
							  options: .transitionCrossDissolve,
							  animations: {
								imageView.image = toImage
			})
			
			// Will show a snow view if we allow to show effects
			// To be learned later
			UIView
				.animate(.promise,
						 duration: 1.0,
						 delay: 0.0,
						 options: .curveEaseOut,
						 animations: {
							self.snowView.alpha = showEffects ? 1.0 : 0.0
				})
				.done({ isCompleted in
					seal.fulfill(isCompleted)
				})
		}
	}
	
	func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) -> Promise<Bool> {
		return Promise { seal in
			let auxLabel = UILabel(frame: label.frame)
			auxLabel.text = text
			auxLabel.font = label.font
			auxLabel.textColor = label.textColor
			auxLabel.textAlignment = label.textAlignment
			auxLabel.backgroundColor = label.backgroundColor
			
			let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
			auxLabel.transform = CGAffineTransform(scaleX: 1.0, y: 0.1)
				.concatenating(CGAffineTransform(translationX: 0.0, y: auxLabelOffset))
			
			label.superview?.addSubview(auxLabel)
			
			UIView
				.animate(.promise,
						 duration: 0.5,
						 delay: 0.0,
						 options: .curveEaseOut,
						 animations: {
							auxLabel.transform = .identity
							label.transform = CGAffineTransform(scaleX: 1.0, y: 0.1)
								.concatenating(CGAffineTransform(translationX: 0.0, y: -auxLabelOffset))
				})
				.done({ isCompleted in
					label.text = auxLabel.text
					label.transform = .identity
					
					auxLabel.removeFromSuperview()
					seal.fulfill(isCompleted)
				})
		}
	}
	
	func moveLabel(label: UILabel, text: String, offset: CGPoint) -> Promise<Bool> {
		return Promise { seal in
			let auxLabel = UILabel(frame: label.frame)
			auxLabel.text = text
			auxLabel.font = label.font
			auxLabel.textColor = label.textColor
			auxLabel.textAlignment = label.textAlignment
			auxLabel.backgroundColor = .clear
			
			auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
			auxLabel.alpha = 0
			view.addSubview(auxLabel)
			
			UIView
				.animate(.promise,
						 duration: 0.5,
						 delay: 0.0,
						 options: .curveEaseIn,
						 animations: {
							label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
							label.alpha = 0.0
				})
			
			UIView
				.animate(.promise,
						 duration: 0.25,
						 delay: 0.1,
						 options: .curveEaseIn,
						 animations: {
							auxLabel.transform = .identity
							auxLabel.alpha = 1.0
				})
				.done({ isCompleted in
					auxLabel.removeFromSuperview()
					
					label.text = text
					label.alpha = 1.0
					label.transform = .identity
					
					seal.fulfill(isCompleted)
				})
		}
	}
	
	func planeDepart() -> Promise<Bool> {
		return Promise { seal in
			let originalCenter = planeImage.center
			
			UIView.animateKeyframes(withDuration: 1.5,
									delay: 0.0,
									options: [],
									animations: {
										UIView.addKeyframe(withRelativeStartTime: 0.0,
														   relativeDuration: 0.25,
														   animations: {
															self.planeImage.center.x += 80
															self.planeImage.center.y -= 10
										})
										
										UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4, animations: {
											self.planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8)
										})
										
										UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
											self.planeImage.center.x += 100
											self.planeImage.center.y -= 50
											self.planeImage.alpha = 0.0
										})
										
										UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01, animations: {
											self.planeImage.transform = .identity
											self.planeImage.center = CGPoint(x: 0.0, y: originalCenter.y)
										})
										
										UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45, animations: {
											self.planeImage.alpha = 1.0
											self.planeImage.center = originalCenter
										})
			}) { isCompleted in
				seal.fulfill(isCompleted)
			}
		}
	}
}

// Calling functions
private extension VCChapter04 {
	func change(toFlight: FlightData, animated: Bool = false) {
		guard let image = UIImage(named: toFlight.weatherImageName) else {
			return
		}
		
		let currentEffect = toFlight.showWeatherEffects
		
		summary.text = toFlight.summary
		
		if !animated {
			bgImageView.image = image
			snowView.isHidden = !currentEffect
			
			flightNr.text = toFlight.flightNr
			gateNr.text = toFlight.gateNr
			departingFrom.text = toFlight.departingFrom
			arrivingTo.text = toFlight.arrivingTo
			flightStatus.text = toFlight.flightStatus
			
		} else {
			let direction: AnimationDirection = toFlight.isTakingOff ? .positive : .negative
			
			let offsetDeparting = CGPoint(x: CGFloat(direction.rawValue * 80), y: 0.0)
			let offsetArriving = CGPoint(x: 0.0, y: CGFloat(direction.rawValue * 50))
			
			_ = fade(imageView: bgImageView,
				 toImage: image,
				 showEffects: currentEffect)
			
			_ = cubeTransition(label: flightNr, text: toFlight.flightNr, direction: direction)
			_ = cubeTransition(label: gateNr, text: toFlight.gateNr, direction: direction)
			
			_ = moveLabel(label: departingFrom, text: toFlight.departingFrom, offset: offsetDeparting)
			_ = moveLabel(label: arrivingTo, text: toFlight.arrivingTo, offset: offsetArriving)
			
			_ = cubeTransition(label: flightStatus, text: toFlight.flightStatus, direction: .negative)
		}
		
		_ = planeDepart()
		
		delay(seconds: 3.0) {
			self.change(toFlight: toFlight.isTakingOff ? parisToRome : londonToParis, animated: true)
		}
	}
}

// Setup for view
private extension VCChapter04 {
	func setupUI() {
		//adjust ui
		summary.addSubview(summaryIcon)
		summaryIcon.center.y = summary.frame.size.height/2
		
		//add the snow effect layer
		snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
		let snowClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 50))
		snowClipView.clipsToBounds = true
		snowClipView.addSubview(snowView)
		view.addSubview(snowClipView)
		
		//start rotating the flights
		change(toFlight: londonToParis)
	}
}

enum AnimationDirection: Int {
	case positive = 1
	case negative = -1
}
