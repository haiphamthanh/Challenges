//
//  ViewController.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/16/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

// MARK: Change testing value to change testing view screen
let chapter = Chapter.one

class ViewController: UIViewController {
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		return action(chapter: chapter)
	}
}

private extension ViewController {
	func action(chapter: Chapter) {
		guard let vc = ChapterFactory.loadVC(chapter: chapter) else {
			return
		}
		
		return change(vc: vc)
	}
	
	func change(vc: UIViewController) {
		present(vc, animated: true, completion: nil)
	}
}
