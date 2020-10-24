//
//  BaseViewControllerOthers.swift
//  DesignPatterns
//
//  Created by HaiKaito on 10/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

class BaseViewControllerOthers<T: RootPresenter>: BaseViewController<T> {
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
