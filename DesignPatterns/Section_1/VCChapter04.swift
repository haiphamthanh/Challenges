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
}

// Calling functions
private extension VCChapter04 {
	func change(toFlight: FlightData, animated: Bool = false) {
		func withoutFade(imageView: UIImageView, toImage: UIImage, showEffects: Bool) -> Promise<Bool> {
			return Promise { seal in
				bgImageView.image = toImage
				snowView.isHidden = !showEffects
				seal.fulfill(true)
			}
		}
		
		guard let image = UIImage(named: toFlight.weatherImageName) else {
			return
		}
		
		let currentEffect = toFlight.showWeatherEffects
		
		summary.text = toFlight.summary
		flightNr.text = toFlight.flightNr
		gateNr.text = toFlight.gateNr
		departingFrom.text = toFlight.departingFrom
		arrivingTo.text = toFlight.arrivingTo
		flightStatus.text = toFlight.flightStatus
		
		let exec = !animated ?
			withoutFade(imageView: bgImageView,
						toImage: image,
						showEffects: currentEffect) :
			fade(imageView: bgImageView,
				 toImage: image,
				 showEffects: currentEffect)
		
		_ = exec.done { _ in
			// schedule next flight
			delay(seconds: 3.0) {
				self.change(toFlight: toFlight.isTakingOff ? parisToRome : londonToParis, animated: true)
			}
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
