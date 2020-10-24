//
//  AppStoryboard.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit

enum Chapter {
	case chapter1
	case chapter4
	case chapter6
	case other1
	
	func clss() -> UIViewController.Type {
		switch self {
		case .chapter1:
			return VCChapter01.self
		case .chapter4:
			return VCChapter04.self
		case .chapter6:
			return VCChapter06.self
		case .other1:
			return VCOtherTableViewLayout.self
		}
	}
}

class ChapterFactory {
	class func loadVC(chapter: Chapter) -> UIViewController? {
		let vc = chapter.clss().newInstance(presenter: BaseRootPresenter())
		return vc
	}
}

// MARK: - =========== Create view controller (Private)
fileprivate struct AppStoryboardInfo {
	let name: String
	let vcs: [AppViewController]
}

// MARK: - =========== View Info (Private)
fileprivate enum ViewInfo {
	case section1
	case section2
	case others
	
	var info: AppStoryboardInfo {
		switch self {
		case .section1:
			return AppStoryboardInfo(name: "Section1",
									 vcs: [])
		case .section2:
			return AppStoryboardInfo(name: "Section2",
									 vcs: [])
		case .others:
			return AppStoryboardInfo(name: "Others",
									 vcs: [.otherView])
		}
	}
}

// MARK: - =========== Storyboard Info (Private)
fileprivate extension ViewInfo {
	static func storyboardName(vcType: UIViewController.Type) -> String? {
		func viewInfo(from vcType: UIViewController.Type) -> ViewInfo? {
			let vcType = AppViewController(vcType: vcType)
			guard vcType != .unknown else {
				return nil
			}
			
			if section1.info.vcs.contains(vcType) {
				return .section1
			}
			
			if section2.info.vcs.contains(vcType) {
				return .section2
			}
			
			if others.info.vcs.contains(vcType) {
				return .others
			}
			
			fatalError("Can't find view controller defination")
		}
		
		guard let screenInfo = viewInfo(from: vcType) else {
			return nil
		}
		
		return screenInfo.info.name
	}
}

// MARK: - =========== Controller Info (Private)
fileprivate enum AppViewController {
	case otherView
	case unknown
	
	init(vcType: UIViewController.Type) {
		switch vcType {
		case is VCOtherTableViewLayout.Type:
			self = .otherView
		default:
			self = .unknown
		}
	}
}

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
		guard let storyboardName = ViewInfo.storyboardName(vcType: self) else {
			return nil
		}
		
		let vc = instantiateFromStoryboard(name: storyboardName, presenter: presenter)
		return vc
	}
}
