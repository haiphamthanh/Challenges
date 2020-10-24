//
//  SampleTableViewCell.swift
//  DesignPatterns
//
//  Created by HaiKaito on 10/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

class SampleTableViewCell: UITableViewCell {
	lazy var seemoreButton: UIButton = {
		let button = UIButton(type: .custom)
		button.isHidden = true
		return button
	}()
	lazy var textView: UITextView = {
		
		let textView = UITextView(frame: CGRect(x: 0, y: 20.0, width: self.frame.width, height: 20.0))
		textView.isHidden = true
		return textView
	}()
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		backgroundColor = .clear
		seemoreButton.isHidden = true
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleShowData))
		seemoreButton.addGestureRecognizer(tap)
		seemoreButton.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 20.0)
		seemoreButton.setTitle("See more", for: .normal)
		
		addSubview(seemoreButton)
	}
	
	func needShowSeemore() {
		seemoreButton.isHidden = false
	}
	
	@objc private func handleShowData() {
		if seemoreButton.titleLabel?.text == "See more" {
			return handleSeemore()
		}
		
		return handleSeeLess()
	}
	
	func handleSeemore() {
		// logic see more
		
		// change text if successful
		return seemoreButton.setTitle("See less", for: .normal)
	}
	
	func handleSeeLess() {
		// logic see less
		
		// change text if successful
		return seemoreButton.setTitle("See less", for: .normal)
	}
}
