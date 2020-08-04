//
//  VCChapter13.swift
//  DesignPatterns
//
//  Created by HaiKaito on 8/3/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

class VCChapter13: BaseViewControllerSection03 {
	// MARK: IBOutlets
	@IBOutlet var myAvatar: AvatarView!
	@IBOutlet var opponentAvatar: AvatarView!
	
	@IBOutlet var status: UILabel!
	@IBOutlet var vs: UILabel!
	@IBOutlet var searchAgain: UIButton!
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		searchForOpponent()
	}
	
	@IBAction func actionSearchAgain() {
		UIApplication.shared.keyWindow!.rootViewController = storyboard!.instantiateViewController(withIdentifier: "ViewController") as UIViewController
	}
	
	func searchForOpponent() {
		// Calculate distance to move
		let avatarSize = myAvatar.frame.size
		let bounceXOffset = CGFloat(avatarSize.width / 1.9)
		let morphSize = CGSize(width: avatarSize.width * 0.85,
							   height: avatarSize.height * 1.1)
		
		// Move forward and backward from original point to new location that add more morphSize
		let rightBouncePoint = CGPoint(x: view.frame.width / 2.0 + bounceXOffset,
									   y: myAvatar.center.y)
		let leftBouncePoint = CGPoint(x: view.frame.width / 2.0 - bounceXOffset,
									  y: myAvatar.center.y)
		
		// Move left to right and Move right to left then reverse all of them
		myAvatar.bounceOff(point: rightBouncePoint, morphSize: morphSize)
		opponentAvatar.bounceOff(point: leftBouncePoint, morphSize: morphSize)
	}
}
