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
//			print("-> \(constraint.description)\n")
			
			isMenuOpen = !isMenuOpen
			menuHeightConstraint.constant = isMenuOpen ? 200.0 : 60.0
			titleLabel.text = isMenuOpen ? "Opened Menu" : "Packing List"
			
			if constraint.firstItem === titleLabel && constraint.firstAttribute == .centerX {
				constraint.constant = isMenuOpen ? -100 : 0.0
				return
			}
			
			if constraint.identifier == "TitleCenterY" {
				constraint.isActive = false
				
				// Add new constrain here
				let newConstrain = NSLayoutConstraint(item: titleLabel!,
													  attribute: .centerY,
													  relatedBy: .equal,
													  toItem: titleLabel.superview,
													  attribute: .centerY,
													  multiplier: isMenuOpen ? 0.67 : 1.0,
													  constant: 5.0)
				newConstrain.identifier = "TitleCenterY"
				newConstrain.isActive = true
				return
			}
		}
		
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
		
		if isMenuOpen {
			slider = HorizontalItemList(inView: view)
			slider.didSelectItem = { index in
				print("add \(index)")
				
				self.items.append(index)
				self.tableView.reloadData()
				self.toggleMenu()
			}
			
			titleLabel.superview?.addSubview(slider)
			return
		}
		
		return slider.removeFromSuperview()
	}
	
	func showItem(at index: Int) {
		print("Tapped item at index \(index)")
		
		// Load image
		let imageName = "summericons_100px_0\(index).png"
		let image = UIImage(named: imageName)
		let imageView = UIImageView(image: image)
		
		// Config view showing
		imageView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
		imageView.layer.cornerRadius = 5.0
		imageView.layer.masksToBounds = true
		view.addSubview(imageView)
		
		//B1: Make constraint for init imageView
		imageView.translatesAutoresizingMaskIntoConstraints = false
		// X position
		let conX = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		// Y position
		let conBottom = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
														  constant: imageView.frame.size.height)
		// width of imageView (0.33% view width and substract to 50)
		let conWidth = imageView.widthAnchor.constraint(equalTo: view.widthAnchor,
														multiplier: 0.33,
														constant: -50.0)
		// Height of imageView
		let conHeight = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
		NSLayoutConstraint.activate([conX, conBottom, conWidth, conHeight])
		// Make sure allthings are executed before we have a new animation things
		view.layoutIfNeeded()
		
		//B2: Animate view to show image
		UIView.animate(withDuration: 0.8,
					   delay: 0.0,
					   usingSpringWithDamping: 0.4,
					   initialSpringVelocity: 0.0,
					   options: [],
					   animations: {
						// Move Y position to screen
						conBottom.constant = -imageView.frame.size.height / 2
						
						// Restore imageView (from -50 to original) size
						conWidth.constant = 0.0
						self.view.layoutIfNeeded()
		}, completion: nil)
		
		// Challenge: Keep the image visible for 1 second and then animate it back out of the screen
		UIView.animate(withDuration: 0.4,
					   delay: 1.0,
					   options: .curveEaseOut,
					   animations: {
						// Move back to init Y position
						conBottom.constant = imageView.frame.size.height
						
						// Restore imageView size to -50
						conWidth.constant = -50.0
						self.view.layoutIfNeeded()
		}) { _ in
			imageView.removeFromSuperview()
		}
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
