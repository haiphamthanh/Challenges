//
//  VCChapter07.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/30/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit
import PromiseKit

class VCChapter07: BaseViewControllerSection03 {
	// MARK: IB Outlets
	@IBOutlet private weak var loginButton: UIButton!
	@IBOutlet private weak var heading: UILabel!
	@IBOutlet private weak var userName: UITextField!
	@IBOutlet private weak var password: UITextField!
	
	@IBOutlet private weak var cloud1: UIImageView!
	@IBOutlet private weak var cloud2: UIImageView!
	@IBOutlet private weak var cloud3: UIImageView!
	@IBOutlet private weak var cloud4: UIImageView!
	
	lazy var animationContainerView: UIView = {
		var tempView = UIView(frame: view.bounds)
		tempView.frame = view.bounds
		tempView.backgroundColor = .red
		view.addSubview(tempView)
		
		return tempView
	}()
	lazy var animations: [UIView.AnimationOptions] = {
		return [.transitionFlipFromLeft,
				.transitionFlipFromRight,
				.transitionCurlUp,
				.transitionCurlDown,
				.transitionCrossDissolve,
				.transitionFlipFromTop,
				.transitionFlipFromBottom]
	}()
	
	// MARK: Further UI
	let spinner = UIActivityIndicatorView(style: .whiteLarge)
	let status = UIImageView(image: UIImage(named: "banner"))
	let label = UILabel()
	let info = UILabel()
	
	var statusPosition = CGPoint.zero
	var processingState = ProcessingState.noAuth {
		didSet {
			return change(state: processingState)
		}
	}
	
	// MARK: View life cycles
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		animateInputScreen()
		disableCloud()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		_ = fadeInCloud()
		_ = fadeInLoginButton()
		animateClouds()
		moveInInstruction()
	}
}

extension VCChapter07: CAAnimationDelegate {
	func animationDidStart(_ anim: CAAnimation) {
	}
	
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		guard let name = anim.value(forKey: "name") as? String else {
			return
		}
		
		if name == "form" {
			let layer = anim.value(forKey: "layer") as? CALayer
			anim.setValue(nil, forKey: "layer")
			
			let pulse = CASpringAnimation(keyPath: "transform.scale")
			pulse.damping = 7.5
			pulse.fromValue = 1.25
			pulse.toValue = 1.0
			pulse.duration = pulse.settlingDuration
			
			layer?.add(pulse, forKey: nil)
		}
		
		if name == "cloud" {
			if let layer = anim.value(forKey: "layer") as? CALayer {
				anim.setValue(nil, forKey: "layer")
				
				layer.position.x = -layer.bounds.width / 2
				delay(seconds: 0.5) {
					self.animateCloud(layer: layer)
				}
			}
			
		}
	}
}

private extension VCChapter07 {
	func animateInputScreen() {
		let formGroup = CAAnimationGroup()
		formGroup.duration = 0.5
		formGroup.fillMode = .backwards
		
		let flyRight = CABasicAnimation(keyPath: "position.x")
		flyRight.fromValue = -view.bounds.size.width / 2
		flyRight.toValue = view.bounds.size.width / 2
		
		let fadeFieldIn = CABasicAnimation(keyPath: "opacity")
		fadeFieldIn.fromValue = 0.25
		fadeFieldIn.toValue = 1.0
		
		formGroup.animations = [flyRight, fadeFieldIn]
		heading.layer.add(formGroup, forKey: nil)
		
		formGroup.delegate = self
		formGroup.setValue("form", forKey: "name")
		
		formGroup.beginTime = CACurrentMediaTime() + 0.3
		formGroup.setValue(userName.layer, forKey: "layer")
		userName.layer.add(formGroup, forKey: nil)
		
		formGroup.beginTime = CACurrentMediaTime() + 0.4
		formGroup.setValue(password.layer, forKey: "layer")
		password.layer.add(formGroup, forKey: nil)
	}
	
	func disableCloud() {
		let fadeIn = CABasicAnimation(keyPath: "opacity")
		fadeIn.fromValue = 1.0
		fadeIn.toValue = 0.0
		fadeIn.duration = 0.5
		fadeIn.fillMode = .backwards
		
		fadeIn.beginTime = CACurrentMediaTime() + 0.5
		cloud1.layer.add(fadeIn, forKey: nil)
		
		fadeIn.beginTime = CACurrentMediaTime() + 0.7
		cloud2.layer.add(fadeIn, forKey: nil)
		
		fadeIn.beginTime = CACurrentMediaTime() + 0.9
		cloud3.layer.add(fadeIn, forKey: nil)
		
		fadeIn.beginTime = CACurrentMediaTime() + 1.1
		cloud4.layer.add(fadeIn, forKey: nil)
	}
	
	func fadeInCloud() -> Promise<Bool> {
		return Promise { seal in
			UIView.animate(.promise, duration: 0.5, delay: 0.5, options: [], animations: {
				self.cloud1.alpha = 1.0
			})
			
			UIView.animate(.promise, duration: 0.5, delay: 0.7, options: [], animations: {
				self.cloud2.alpha = 1.0
			})
			
			UIView.animate(.promise, duration: 0.5, delay: 0.9, options: [], animations: {
				self.cloud3.alpha = 1.0
			})
			
			UIView
				.animate(.promise, duration: 0.5, delay: 1.1, options: [], animations: {
					self.cloud4.alpha = 1.0
				})
				.done({ isCompleted in
					seal.fulfill(isCompleted)
				})
		}
	}
	
	func fadeInLoginButton() -> Promise<Bool> {
		return Promise { seal in
			let groupAnimation = CAAnimationGroup()
			groupAnimation.beginTime = CACurrentMediaTime() + 0.5
			groupAnimation.duration = 3
			groupAnimation.fillMode = .backwards
			groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
			
			let scaleDown = CABasicAnimation(keyPath: "transform.scale")
			scaleDown.fromValue = 3.5
			scaleDown.toValue = 1.0
			
			let rotate = CABasicAnimation(keyPath: "transform.rotation")
			rotate.fromValue = .pi / 4.0
			rotate.toValue = 0.0
			
			let fade = CABasicAnimation(keyPath: "opacity")
			fade.fromValue = 0.0
			fade.toValue = 1.0
			
			groupAnimation.animations = [scaleDown, rotate, fade]
			loginButton.layer.add(groupAnimation, forKey: nil)
			
			seal.fulfill(true)
		}
	}
	
	func moveInInstruction() {
		let flyLeft = CABasicAnimation(keyPath: "position.x")
		flyLeft.fromValue = info.layer.position.x + view.frame.size.width
		flyLeft.toValue = info.layer.position.x
		flyLeft.duration = 5.0
		
		let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
		fadeLabelIn.fromValue  = 0.2
		fadeLabelIn.toValue = 1.0
		fadeLabelIn.duration = 4.5
		
		info.layer.add(flyLeft, forKey: "infoappear")
		info.layer.add(fadeLabelIn, forKey: "fadein")
	}
	
	func increaseButtonSize() -> Promise<Bool> {
		return Promise { seal in
			UIView
				.animate(.promise,
						 duration: 1.5,
						 delay: 0.0,
						 usingSpringWithDamping: 0.2,
						 initialSpringVelocity: 0.0,
						 animations: {
							self.loginButton.bounds.size.width += 80.0
				})
			
			UIView
				.animate(.promise,
						 duration: 0.33,
						 delay: 0.0,
						 usingSpringWithDamping: 0.7,
						 initialSpringVelocity: 0.0,
						 animations: {
							let tintColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
							self.loginButton.center.y += 60
							tintBgColor(layer: self.loginButton.layer, toColor: tintColor)
							
							let xAxis = CGFloat(40)
							let yAxis = self.loginButton.frame.size.height / 2.0
							self.spinner.center = CGPoint(x: xAxis, y: yAxis)
							self.spinner.alpha = 1.0
				})
				.done({ isCompleted in
					roundCorners(layer: self.loginButton.layer, toRadius: 25.0)
					seal.fulfill(isCompleted)
				})
		}
	}
	
	func restoreButtonSize() -> Promise<Bool> {
		return Promise { seal in
			UIView
				.animate(.promise, duration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, animations: {
					self.loginButton.bounds.size.width -= 80.0
				})
			
			UIView
				.animate(.promise, duration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, animations: {
					let tintColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
					self.loginButton.center.y -= 60
					tintBgColor(layer: self.loginButton.layer, toColor: tintColor)
					
					self.spinner.center = CGPoint(x: -20.0, y: 16.0)
					self.spinner.alpha = 0.0
				})
				.done({ isCompleted in
					roundCorners(layer: self.loginButton.layer, toRadius: 10.0)
					seal.fulfill(isCompleted)
				})
		}
	}
	
	func verify(textField: UITextField, isSketch: Bool) -> Promise<Bool> {
		return Promise { seal in
			seal.fulfill(true)
			
			guard let text = textField.text else {
				return
			}
			
			if text.count < 5 {
				let jump = CASpringAnimation(keyPath: "position.y")
				jump.fromValue = textField.layer.position.y + 1.0
				jump.toValue = textField.layer.position.y
				
				jump.initialVelocity = 100.0
				jump.mass = 10.0
				jump.stiffness = 1500.0
				jump.damping = 50
				jump.duration = jump.settlingDuration
				
				textField.layer.borderWidth = 3.0
				textField.layer.borderColor = UIColor.clear.cgColor
				
				let flash = CASpringAnimation(keyPath: "borderColor")
				flash.damping = 7.0
				flash.stiffness = 200.0
				flash.fromValue =  UIColor(red: 1.0, green: 0.27, blue: 0.0, alpha: 1.0).cgColor
				flash.toValue = UIColor.white.cgColor
				flash.duration = flash.settlingDuration
				
				textField.layer.add(jump, forKey: nil)
				textField.layer.add(flash, forKey: nil)
			}
		}
	}
	
	func transitionSample() -> Promise<Bool> {
		return Promise { seal in
			let newView = UIImageView(image: UIImage(named: "banner"))
			newView.center = animationContainerView.center
			
			UIView
				.transition(.promise,
							with: animationContainerView,
							duration: 0.33,
							options: [.curveEaseOut, .transitionFlipFromBottom],
							animations: {
								self.animationContainerView.addSubview(newView)
				})
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				UIView
					.transition(.promise,
								with: self.animationContainerView,
								duration: 0.33,
								options: [.curveEaseOut, .transitionFlipFromBottom],
								animations: {
									newView.removeFromSuperview()
					})
					.done({ isCompleted in
						seal.fulfill(isCompleted)
					})
			}
		}
	}
	
	func show(mssg: String) -> Promise<Bool> {
		return Promise { seal in
			label.text = mssg
			
			UIView
				.transition(.promise,
							with: status,
							duration: 0.33,
							options: [.curveEaseOut, animations.randomElement()!],
							animations: {
								self.status.isHidden = false
				})
				.done({ isCompleted in
					seal.fulfill(isCompleted)
				})
		}
	}
	
	func removeMessage(_ mssg: String) -> Promise<Bool> {
		let chainProcess: Promise<Bool> = Promise { seal in
			label.text = mssg
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
				UIView
					.animate(.promise, duration: 0.33, animations: {
						self.status.center.x += self.view.frame.size.width
					})
					.done({ isCompleted in
						self.status.isHidden = true
						self.status.center = self.statusPosition
						
						seal.fulfill(isCompleted)
					})
			})
		}
		
		return chainProcess
	}
	
	func animateClouds() {
		_ = animateCloud(layer: cloud1.layer)
		_ = animateCloud(layer: cloud2.layer)
		_ = animateCloud(layer: cloud3.layer)
		_ = animateCloud(layer: cloud4.layer)
	}
	
	func animateCloud(layer: CALayer) {
		// 1. data for computing
		let cloudSpeed = 60.0 / self.view.frame.size.width
		let duration = (self.view.frame.size.width - layer.frame.origin.x) * cloudSpeed
		
		// 2. Animation action
		let cloudMove = CABasicAnimation(keyPath: "position.x")
		cloudMove.delegate = self
		cloudMove.duration = CFTimeInterval(duration)
		cloudMove.toValue = view.frame.size.width + layer.bounds.width / 2
		cloudMove.setValue("cloud", forKey: "name")
		cloudMove.setValue(layer, forKey: "layer")
		
		layer.add(cloudMove, forKey: nil)
	}
	
	func change(state: ProcessingState) {
		switch state {
		case .noAuth:
			return
		case .connecting:
			lockInput()
			increaseButtonSize()
				.compactMap({ _ -> Promise<Bool> in
					let mssg = state.mssg
					return self.show(mssg: mssg)
				})
				.catch({ err in
					print(err.localizedDescription)
				})
		case .sendingCre:
			return
		case .authorized, .failed:
			let mssg = state.mssg
			removeMessage(mssg)
				.map({ _ -> Void in })
				.compactMap(restoreButtonSize)
				.done { _ in
					self.unlockInput()
				}.catch({ err in
					print(err.localizedDescription)
				})
		}
	}
}

private extension VCChapter07 {
	func setupUI() {
		loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
		loginButton.layer.cornerRadius = 8.0
		loginButton.layer.masksToBounds = true
		
		spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
		spinner.startAnimating()
		spinner.alpha = 0.0
		
		status.isHidden = true
		status.center = loginButton.center
		
		label.frame = CGRect(x: 0.0,
							 y: 0.0,
							 width: status.frame.size.width,
							 height: status.frame.size.height)
		label.font = UIFont(name: "HelveticaNeue", size: 18.0)
		label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
		label.textAlignment = .center
		
		info.frame = CGRect(x: 0.0,
							y: loginButton.center.y + 60.0,
							width: view.frame.size.width,
							height: 30)
		info.backgroundColor = .clear
		info.font = UIFont(name: "HelveticaNeue", size: 12.0)
		info.textAlignment = .center
		info.textColor = .white
		info.text = "Tap on a field and enter usernam and password"
		
		userName.delegate = self
		password.delegate = self
		statusPosition = status.center
		
		loginButton.addSubview(spinner)
		status.addSubview(label)
		view.insertSubview(info, belowSubview: loginButton)
		view.addSubview(status)
		
		let viewTap = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
		view.addGestureRecognizer(viewTap)
	}
	
	@objc func login(sender: UIButton!) {
		connect()
			.compactMap(didReceived)
			.done({ _ -> Void in })
			.catch({ err in
				print(err.localizedDescription)
			})
	}
	
	@objc func endEditing() {
		view.endEditing(true)
	}
	
	func lockInput() {
		endEditing()
		userName.isEnabled = false
		password.isEnabled = false
		
		userName.backgroundColor = .lightGray
		password.backgroundColor = .lightGray
		
		loginButton.isEnabled = false
	}
	
	func unlockInput() {
		userName.isEnabled = true
		password.isEnabled = true
		
		userName.backgroundColor = .white
		password.backgroundColor = .white
		
		loginButton.isEnabled = true
	}
}

// Actions
private extension VCChapter07 {
	func connect() -> Promise<Bool> {
		return Promise { seal in
			processingState = .connecting
			
			// Wait in 5 secconds and push temporary data
			DispatchQueue
				.global()
				.asyncAfter(deadline: .now() + 5, execute: {
					seal.fulfill(false)
				})
		}
	}
	
	func didReceived(_ connectState: Bool) -> Promise<Void> {
		return Promise { seal in
			processingState = connectState ? .authorized : .failed
			return seal.fulfill_()
		}
	}
}

extension VCChapter07: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
	}
	
	func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
		_ = verify(textField: textField, isSketch: false)
		
		info.layer.removeAllAnimations()
	}
}
