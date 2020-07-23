//
//  VCChapter01.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/22/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

// Chapter 1: View Animations
import UIKit

enum ProcessingState: String {
	case connecting = "Connecting..."
	case auth = "Authorizing..."
	case sendingCre = "Sending credentials..."
	case done = "Done"
	case failed = "Failed"
	
	var mssg: String {
		return rawValue
	}
}

class VCChapter01: BaseViewControllerSection01 {
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
	
	// MARK: Further UI
	let spinner = UIActivityIndicatorView(style: .whiteLarge)
	let status = UIImageView(image: UIImage(named: "banner"))
	let label = UILabel()
	
	var statusPosition = CGPoint.zero
	var processingState = ProcessingState.done {
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
		
		moveOutInputScreen()
		disableCloud()
		disableLoginButton()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		moveInTitle()
		fadeInCloud()
		fadeInLoginButton()
	}
}

private extension VCChapter01 {
	func moveOutInputScreen() {
		heading.center.x -= view.bounds.width
		userName.center.x -= view.bounds.width
		password.center.x -= view.bounds.width
	}
	
	func moveInTitle() {
		// Show tille first
		UIView.animate(withDuration: 0.5) {
			self.heading.center.x += self.view.bounds.width
		}
		
		// Next show username field
		UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
			self.userName.center.x += self.view.bounds.width
		}, completion: nil)
		
		// Finally, show password field
		UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
			self.password.center.x += self.view.bounds.width
		}, completion: nil)
	}
	
	func disableCloud() {
		cloud1.alpha = 0.0
		cloud2.alpha = 0.0
		cloud3.alpha = 0.0
		cloud4.alpha = 0.0
	}
	
	func disableLoginButton() {
		// Move button down 30pt and hide it
		loginButton.center.y += 30
		loginButton.alpha = 0.0
	}
	
	func fadeInCloud() {
		UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
			self.cloud1.alpha = 1.0
		}, completion: nil)
		
		UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
			self.cloud2.alpha = 1.0
		}, completion: nil)
		
		UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
			self.cloud3.alpha = 1.0
		}, completion: nil)
		
		UIView.animate(withDuration: 0.5, delay: 1.1, options: [], animations: {
			self.cloud4.alpha = 1.0
		}, completion: nil)
	}
	
	func fadeInLoginButton() {
		UIView.animate(withDuration: 0.5,
					   delay: 0.5,
					   usingSpringWithDamping: 0.5,
					   initialSpringVelocity: 0.0,
					   options: [],
					   animations: {
						self.loginButton.center.y -= 30.0
						self.loginButton.alpha = 1.0
		}, completion: nil)
	}
	
	func increaseButtonSize(completion: ((Bool) -> Void)? = nil) {
		UIView.animate(withDuration: 1.5,
					   delay: 0.0,
					   usingSpringWithDamping: 0.2,
					   initialSpringVelocity: 0.0,
					   options: [],
					   animations: {
						self.loginButton.bounds.size.width += 80.0
		}, completion: nil)
		
		UIView.animate(withDuration: 0.33,
					   delay: 0.0,
					   usingSpringWithDamping: 0.7,
					   initialSpringVelocity: 0.0,
					   options: [],
					   animations: {
						let loginBtnColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
						self.loginButton.center.y += 60
						self.loginButton.backgroundColor = loginBtnColor
						
						let xAxis = CGFloat(40)
						let yAxis = self.loginButton.frame.size.height / 2.0
						self.spinner.center = CGPoint(x: xAxis, y: yAxis)
						self.spinner.alpha = 1.0
		}, completion: completion)
	}
	
	func restoreButtonSize(completion: ((Bool) -> Void)? = nil) {
		UIView.animate(withDuration: 1.5,
					   delay: 0.0,
					   usingSpringWithDamping: 0.2,
					   initialSpringVelocity: 0.0,
					   options: [],
					   animations: {
						self.loginButton.bounds.size.width -= 80.0
		}, completion: nil)
		
		UIView.animate(withDuration: 0.33,
					   delay: 0.0,
					   usingSpringWithDamping: 0.7,
					   initialSpringVelocity: 0.0,
					   options: [],
					   animations: {
						let loginBtnColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
						self.loginButton.center.y -= 60
						self.loginButton.backgroundColor = loginBtnColor
						
						self.spinner.center = CGPoint(x: -20.0, y: 16.0)
						self.spinner.alpha = 0.0
		}, completion: completion)
	}
	
	func changeSize(textField: UITextField, isSketch: Bool) {
		UIView.animate(withDuration: 0.7,
					   delay: 0.0,
					   usingSpringWithDamping: 0.2,
					   initialSpringVelocity: 0.0,
					   options: [],
					   animations: {
						textField.bounds.size.width += isSketch ? 40 : -40
		}, completion: nil)
	}
	
	func transitionSample() {
		let newView = UIImageView(image: UIImage(named: "banner"))
		newView.center = animationContainerView.center
		
		UIView.transition(with: animationContainerView,
						  duration: 0.33,
						  options: [.curveEaseOut, .transitionFlipFromBottom],
						  animations: {
							self.animationContainerView.addSubview(newView)
		}, completion: nil)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			UIView.transition(with: self.animationContainerView,
							  duration: 0.33,
							  options: [.curveEaseOut, .transitionFlipFromBottom],
							  animations: {
								newView.removeFromSuperview()
			}, completion: nil)
		}
	}
	
	func show(mssg: String, completion: ((Bool) -> Void)? = nil) {
		label.text = mssg
		
		UIView.transition(with: status,
						  duration: 0.33,
						  options: [.curveEaseOut, .transitionCurlDown],
						  animations: {
							self.status.isHidden = false
		}, completion: completion)
	}
	
	func hideMessage(mssg: String, completion: ((Bool) -> Void)? = nil) {
		UIView.transition(with: label,
						  duration: 0.33,
						  options: .transitionFlipFromTop,
						  animations: {
							self.label.text = mssg
		}, completion: { _ in
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
				UIView.transition(with: self.status,
								  duration: 0.33,
								  options: [.curveEaseOut, .transitionCurlUp],
								  animations: {
									self.status.isHidden = true
				}, completion: completion)
			}
		})
		
	}
	
	func change(state: ProcessingState) {
		switch state {
		case .auth:
			break
		case .connecting:
			lockInput()
			increaseButtonSize { (_) in
				let mssg = state.mssg
				self.show(mssg: mssg)
			}
		case .sendingCre:
			break
		case .done:
			let mssg = state.mssg
			hideMessage(mssg: mssg) { _ in
				self.restoreButtonSize(completion: { _ in
					self.unlockInput()
				})
			}
		case .failed:
			break
		}
	}
}

private extension VCChapter01 {
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
		
		userName.delegate = self
		password.delegate = self
		
		loginButton.addSubview(spinner)
		status.addSubview(label)
		view.addSubview(status)
		
		let viewTap = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
		view.addGestureRecognizer(viewTap)
	}
	
	@objc func login(sender: UIButton!) {
		connect()
		
		// Wait in 5 secconds
		DispatchQueue
			.main
			.asyncAfter(deadline: .now() + 5, execute: done)
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
private extension VCChapter01 {
	func connect() {
		processingState = .connecting
	}
	
	func done() {
		processingState = .done
	}
}

extension VCChapter01: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		changeSize(textField: textField, isSketch: true)
	}
	
	func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
		changeSize(textField: textField, isSketch: false)
	}
}
