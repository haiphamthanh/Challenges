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
		
	}
	
	@IBAction func actionSearchAgain() {
		UIApplication.shared.keyWindow!.rootViewController = storyboard!.instantiateViewController(withIdentifier: "ViewController") as UIViewController
	}
}
