//
//  ViewController.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/16/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

// MARK: Change testing value to change testing view screen
let testingType = ChapterView.chapter7

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
		
        return action(viewType: testingType)
    }
}

private extension ViewController {
    func action(viewType: ChapterView) {
        let vc = viewType.loadVC()
        return change(vc: vc)
    }
    
    func change(vc: UIViewController) {
		present(vc, animated: true, completion: nil)
    }
}

// Define tesing views
enum ChapterView: String {
    case chapter1 = "VCChapter01"
	case chapter4 = "VCChapter04"
	case chapter6 = "VCChapter06"
	case chapter7 = "VCChapter07"
    
    func loadVC() -> UIViewController {
        func storyboard(section: Section, name: String) -> UIViewController {
            return section
                .loadStoryboard()
                .instantiateViewController(withIdentifier: name)
        }
		
		let sectionType = section(from: self)
        return storyboard(section: sectionType, name: rawValue)
    }
	
	func section(from chapter: ChapterView) -> Section {
		switch chapter {
		case .chapter1, .chapter4:
			return .one
		case .chapter6:
			return .two
		case .chapter7:
			return .three
		}
	}
}

enum Section: String {
    case one = "Section1"
	case two = "Section2"
	case three = "Section3"
    
    func loadStoryboard() -> UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: nil)
    }
}
