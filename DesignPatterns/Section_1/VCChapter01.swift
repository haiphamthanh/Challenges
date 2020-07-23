//
//  VCChapter01.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/22/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

// Chapter 1: View Animations
import UIKit
import PromiseKit

enum ProcessingState: String {
	case noAuth = "No Authorization"
	case connecting = "Connecting..."
	case sendingCre = "Sending credentials..."
	case authorized = "Authorized"
	case failed = "Failed"
	
	var mssg: String {
		return rawValue
	}
	
	var next: ProcessingState {
		switch self {
		case .noAuth:
			return .connecting
		case .connecting:
			return .sendingCre
		case .sendingCre:
			return .sendingCre
		case .authorized:
			return .authorized
		case .failed:
			return .noAuth
		}
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
		
		moveOutInputScreen()
		disableCloud()
		disableLoginButton()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		_ = moveInTitle()
		_ = fadeInCloud()
		_ = fadeInLoginButton()
	}
}

private extension VCChapter01 {
	func moveOutInputScreen() {
		heading.center.x -= view.bounds.width
		userName.center.x -= view.bounds.width
		password.center.x -= view.bounds.width
	}
	
	func moveInTitle() -> Promise<Bool> {
		return Promise { seal in
			// Show tille first
			UIView.animate(.promise, duration: 0.5, animations: {
				self.heading.center.x += self.view.bounds.width
			})
			
			// Next show username field
			UIView.animate(.promise, duration: 0.5, delay: 0.3, options: [], animations: {
				self.userName.center.x += self.view.bounds.width
			})
			
			// Finally, show password field
			UIView
				.animate(.promise, duration: 0.5, delay: 0.4, options: [], animations: {
					self.password.center.x += self.view.bounds.width
				})
				.done({ isCompleted in
					seal.fulfill(isCompleted)
				})
		}
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
			UIView
				.animate(.promise,
						 duration: 0.5,
						 delay: 0.5,
						 usingSpringWithDamping: 0.5,
						 initialSpringVelocity: 0.0,
						 animations: {
							self.loginButton.center.y -= 30.0
							self.loginButton.alpha = 1.0
				})
				.done({ isCompleted in
					seal.fulfill(isCompleted)
				})
		}
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
							let loginBtnColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
							self.loginButton.center.y += 60
							self.loginButton.backgroundColor = loginBtnColor
							
							let xAxis = CGFloat(40)
							let yAxis = self.loginButton.frame.size.height / 2.0
							self.spinner.center = CGPoint(x: xAxis, y: yAxis)
							self.spinner.alpha = 1.0
				})
				.done({ isCompleted in
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
					let loginBtnColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
					self.loginButton.center.y -= 60
					self.loginButton.backgroundColor = loginBtnColor
					
					self.spinner.center = CGPoint(x: -20.0, y: 16.0)
					self.spinner.alpha = 0.0
				})
				.done({ isCompleted in
					seal.fulfill(isCompleted)
				})
		}
	}
	
	func changeSize(textField: UITextField, isSketch: Bool) -> Promise<Bool> {
		return Promise { seal in
			UIView
				.animate(.promise,
						 duration: 0.7,
						 delay: 0.0,
						 usingSpringWithDamping: 0.2,
						 initialSpringVelocity: 0.0,
						 animations: {
							textField.bounds.size.width += isSketch ? 40 : -40
				})
				.done({ isCompleted in
					seal.fulfill(isCompleted)
				})
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
							options: [.curveEaseOut, .transitionCurlDown],
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
			UIView
				.animate(.promise, duration: 0.33, animations: {
					self.status.center.x += self.view.frame.size.width
				})
				.done({ isCompleted in
					self.status.isHidden = true
					self.status.center = self.statusPosition
					
					seal.fulfill(isCompleted)
				})
		}
		
		return chainProcess
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
		case .authorized:
			let mssg = state.mssg
			removeMessage(mssg)
				.map({ _ -> Void in })
				.compactMap(restoreButtonSize)
				.done { _ in
					self.unlockInput()
				}.catch({ err in
					print(err.localizedDescription)
				})
		case .failed:
			return
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
		statusPosition = status.center
		
		loginButton.addSubview(spinner)
		status.addSubview(label)
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
private extension VCChapter01 {
	func connect() -> Promise<Bool> {
		return Promise { seal in
			processingState = .connecting
			
			// Wait in 5 secconds and push temporary data
			DispatchQueue
				.global()
				.asyncAfter(deadline: .now() + 5, execute: {
					seal.fulfill(true)
				})
		}
	}
	
	func didReceived(_ connectState: Bool) -> Promise<Void> {
		return Promise { seal in
			processingState = connectState ? .authorized : .noAuth
			return seal.fulfill_()
		}
	}
}

extension VCChapter01: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		_ = changeSize(textField: textField, isSketch: true)
	}
	
	func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
		_ = changeSize(textField: textField, isSketch: false)
	}
}
