//
//  AnimationChallenging.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/30/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

func tintBgColor(layer: CALayer, toColor: UIColor) {
	let backgroundColor = CABasicAnimation(keyPath: "backgroundColor")
	backgroundColor.fromValue = layer.backgroundColor
	backgroundColor.toValue = toColor.cgColor
	backgroundColor.duration = 1.0
	
	layer.add(backgroundColor, forKey: nil)
	layer.backgroundColor = toColor.cgColor
}

func roundCorners(layer: CALayer, toRadius: CGFloat) {
	let cornerRadius = CABasicAnimation(keyPath: "cornerRadius")
	cornerRadius.toValue = toRadius
	cornerRadius.duration = 0.33
	
	layer.add(cornerRadius, forKey: nil)
	layer.cornerRadius = toRadius
}
