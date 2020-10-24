//
//  SampleTableViewCellHeader.swift
//  DesignPatterns
//
//  Created by HaiKaito on 10/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

class SampleTableViewCellHeader: UITableViewHeaderFooterView {
	@IBOutlet weak var sampleView: UIView!
	static let reuseIdentifier: String = String(describing: self)
	
	static var nib: UINib {
		return UINib(nibName: String(describing: self), bundle: nil)
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		
		backgroundColor = .blue
		backgroundView?.backgroundColor = .blue
		contentView.backgroundColor = .blue
	}
	
	func config(color: UIColor) {
		backgroundColor = .blue
		backgroundView?.backgroundColor = .blue
		contentView.backgroundColor = .blue
		sampleView.backgroundColor = color
	}
	
//	override func prepareForReuse() {
//		super.prepareForReuse()
//
//		backgroundColor = .blue
//		backgroundView?.backgroundColor = .blue
//		contentView.backgroundColor = .blue
//	}
}
