//
//  VCChapter06.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/30/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

class VCChapter06: BaseViewControllerSection02 {
	// MARK: IB Outlets
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var buttonMenu: UIButton!
	@IBOutlet private weak var titleLabel: UILabel!
	
	// MARK: further class variables
	private var slider: HorizontalItemList!
	private var isMenuOpen = false
	private var items: [Int] = [5, 6, 7]
	private let itemTitles = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]
	
	// MARK: Layout constrains
	@IBOutlet private weak var menuHeightConstraint: NSLayoutConstraint!
	
	
	// MARK: View life cycles
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
}

// MARK: - View Outlets
private extension VCChapter06 {
	@objc func btnToggleMenu(_ btn: UIButton) {
		return toggleMenu()
	}
}

// MARK: - Actions
private extension VCChapter06 {
	func setupUI() {
		tableView.delegate = self
		tableView.dataSource = self
		
		buttonMenu.addTarget(self, action: #selector(self.btnToggleMenu), for: .touchUpInside)
	}
	
	func toggleMenu() {
		titleLabel.superview?.constraints.forEach { constraint in
			print("-> \(constraint.description)\n")
			
			if constraint.firstItem === titleLabel && constraint.firstAttribute == .centerX {
				constraint.constant = isMenuOpen ? -100 : 0.0
				return
			}
		}
		
		isMenuOpen = !isMenuOpen
		menuHeightConstraint.constant = isMenuOpen ? 200.0 : 60.0
		titleLabel.text = isMenuOpen ? "Opened Menu" : "Packing List"
		
		UIView.animate(withDuration: 1.0,
					   delay: 0.0,
					   usingSpringWithDamping: 0.4,
					   initialSpringVelocity: 10.0,
					   options: .curveEaseIn,
					   animations: {
						self.view.layoutIfNeeded()
						
						let angle: CGFloat = self.isMenuOpen ? .pi / 4 : 0.0
						self.buttonMenu.transform = CGAffineTransform(rotationAngle: angle)
		}, completion: nil)
	}
	
	func showItem(at index: Int) {
		print("Tapped item at index \(index)")
	}
}

// Table view methods
extension VCChapter06: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
		let itemIndex = items[indexPath.row]
		let itemTitle = itemTitles[itemIndex]
		let imageName = "summericons_100px_0\(itemIndex).png"
		
		cell.accessoryType = .none
		cell.textLabel?.text = itemTitle
		cell.imageView?.image = UIImage(named: imageName)
		
		return cell
	}
}

extension VCChapter06: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let itemIndex = items[indexPath.row]
		return showItem(at: itemIndex)
	}
}
