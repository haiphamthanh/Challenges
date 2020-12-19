//
//  AppStoryboard.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit

// MARK: - =========== Public Interface
class ChapterFactory {
	class func loadVC(chapter: Chapter) -> UIViewController? {
		let vc = chapter.vc.newInstance(presenter: BaseRootPresenter())
		return vc
	}
}

// MARK: ===== Section
enum Section: String, CaseIterable {
	case one = "Section1"
	case two = "Section2"
	case three = "Section3"
	
	var chapters: [Chapter] {
		switch self {
		case .one:
			return [.one, .four]
		case .two:
			return [.six]
		case .three:
			return [.seven, .thirdTeen]
		}
	}
	
	init?(from chapter: Chapter) {
		guard let section = Section
			.allCases
			.first(where: { $0.chapters.contains(chapter) }) else {
				fatalError("Cant find view controller defination")
		}
		
		self = section
	}
}

// MARK: ===== Chapter
enum Chapter {
	case one
	case four
	case six
	case seven
	case thirdTeen
	
	var vc: UIViewController.Type {
		switch self {
		case .one:
			return VCChapter01.self
		case .four:
			return VCChapter04.self
		case .six:
			return VCChapter06.self
		case .seven:
			return VCChapter07.self
		case .thirdTeen:
			return VCChapter13.self
		}
	}
	
	init?(from vcType: UIViewController.Type) {
		switch vcType {
		case is VCChapter01.Type:
			self = .one
		case is VCChapter04.Type:
			self = .four
		case is VCChapter06.Type:
			self = .six
		case is VCChapter07.Type:
			self = .seven
		case is VCChapter13.Type:
			self = .thirdTeen
		default:
			fatalError("Cant find view controller defination")
			break
		}
	}
}

// MARK: - =========== Base MVP functions (Public)
protocol RootPresenter {
}

class BaseRootPresenter: RootPresenter {
}

class BaseViewController<T>: UIViewController where T: RootPresenter {
	fileprivate var presenter: RootPresenter?
}

// MARK: - =========== Utils creator (Public)
extension UIViewController {
	static func instantiateFromNib() -> Self {
		func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
			return T.init(nibName: String(describing: T.self), bundle: nil)
		}
		
		return instantiateFromNib(self)
	}
	
	static func newInstance<T: RootPresenter>(presenter: T) -> Self? {
		guard let chapter = Chapter(from: self), let section = Section(from: chapter) else {
			return nil
		}
		
		let vc = instantiateFromStoryboard(name: section.rawValue, presenter: presenter)
		return vc
	}
}

// MARK: - =========== Controller Info (Private)

// MARK: - =========== Controller creator (Private)
private extension UIViewController {
	static func instantiateFromStoryboard<K: RootPresenter>(name: String, presenter: K) -> Self {
		func instantiateFromStoryboard<T: UIViewController, B: RootPresenter>(_ viewType: T.Type, presenter: B) -> T {
			let storyboard = UIStoryboard.init(name: name, bundle: nil)
			let vcName = String(describing: T.self)
			
			let vc = storyboard.instantiateViewController(withIdentifier: vcName)
			if let vc = vc as? BaseViewController<B> {
				vc.presenter = presenter
			}
			
			guard let promiseVC = vc as? T else {
				fatalError("Cant find view controller defination")
			}
			
			return promiseVC
		}
		
		return instantiateFromStoryboard(self, presenter: presenter)
	}
}
