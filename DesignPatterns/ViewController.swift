//
//  ViewController.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/16/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

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
        UIView.transition(from: view, to: vc.view, duration: 0.4) { [weak self] (_) in
            self?.view.removeFromSuperview()
        }
    }
}

// Define tesing views
let testingType = ChapterView.chapter1
enum ChapterView: String {
    case chapter1 = "VCChapter01"
    
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
