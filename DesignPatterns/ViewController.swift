//
//  ViewController.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/16/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

// MARK: Change testing value to change testing view screen
let testingType = ChapterView.chapter4

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
    
    func loadVC() -> UIViewController {
        func storyboard(section: Section, name: String) -> UIViewController {
            return section
                .loadStoryboard()
                .instantiateViewController(withIdentifier: name)
        }
        
        return storyboard(section: .one, name: rawValue)
    }
}

enum Section: String {
    case one = "Section1"
    
    func loadStoryboard() -> UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: nil)
    }
}
