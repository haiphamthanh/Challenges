//
//  BaseViewControllerSection01.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/22/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

class BaseViewControllerSection01: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let labelFrame = view.frame
//        let labelName = String(describing: type(of: self))
//
//        let viewName = UILabel(frame: labelFrame)
//        viewName.text = labelName
//        viewName.textAlignment = .center
//
//        view.addSubview(viewName)
//        view.backgroundColor = hexColor("#A6C964")
    }
}

func hexColor(_ hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
