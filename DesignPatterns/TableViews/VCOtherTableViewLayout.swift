//
//  VCOtherTableViewLayout.swift
//  DesignPatterns
//
//  Created by HaiKaito on 10/17/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

class VCOtherTableViewLayout: BaseViewControllerOthers<BaseRootPresenter>, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet private weak var sampleTableView: UITableView!
//	let dataSource: ViewOtherDataSource
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		sampleTableView.dataSource = self
		sampleTableView.delegate = self
		
//		sampleTableView.register(SampleTableViewCellHeader.self, forHeaderFooterViewReuseIdentifier: String(describing:
//			SampleTableViewCellHeader.self))
		sampleTableView.register(SampleTableViewCellHeader.nib, forHeaderFooterViewReuseIdentifier: SampleTableViewCellHeader.reuseIdentifier)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellIdentifier", for: indexPath) as! SampleTableViewCell
		
		if indexPath.row % 2 == 0 {
//			cell.imageView?.image = UIImage(named: "\(indexPath.row)")
			cell.textLabel?.text = "\(indexPath.row)"
			cell.backgroundColor = .red
			cell.needShowSeemore()
		} else {
			cell.textLabel?.text = "\(indexPath.row)"
			cell.backgroundColor = .yellow
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		//		let myCustomView: SampleTableViewCellHeader = UIView.fromNib()
		//		return myCustomView
		let myCustomView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SampleTableViewCellHeader.reuseIdentifier) as! SampleTableViewCellHeader
		myCustomView.config(color: .green)
		
		return myCustomView
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		//		let myCustomView: SampleTableViewCellHeader = UIView.fromNib()
		//		return myCustomView
		let myCustomView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SampleTableViewCellHeader.reuseIdentifier) as! SampleTableViewCellHeader
		myCustomView.config(color: .brown)
		
		return myCustomView
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 100
	}
}

extension UIView {
	class func fromNib<T: UIView>() -> T {
		return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
	}
}

protocol ViewOtherDataSource {
	var dataSource: [TableSection] { get }
}

//extension presenter: ViewDataSource {
//
//}

enum TableSection {
	case section1([RowValue])
	case section2([RowValue])
	case section3([RowValue])
}

struct RowValue {
	let title: String
	let value: String
}

class OtherPresenter: RootPresenter {
}
