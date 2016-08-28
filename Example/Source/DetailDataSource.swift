//
//  DetailDataSource.swift
//  Example
//
//  Created by Pierre-Jean Quillere on 03/07/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

import UIKit
import AdvancedCollectionView

class BasicDataSource: AAPLBasicDataSource {
	
	override init() {
		super.init()
		
		let metrics = self.defaultMetrics
		metrics.numberOfColumns   = 1
		metrics.showsRowSeparator = true
	}
	
	override func registerReusableViewsWithCollectionView(collectionView: UICollectionView) {
		super.registerReusableViewsWithCollectionView(collectionView)
		
		collectionView.registerClass(AAPLBasicCell.self, forCellWithReuseIdentifier: "BasicCell")
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let text = self.itemAtIndexPath(indexPath) as? String
		
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BasicCell", forIndexPath: indexPath) as! AAPLBasicCell
		cell.style = .Subtitle
		cell.primaryLabel.text = text
		cell.primaryLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
		return cell
	}
	
	override func loadContentWithProgress(progress: AAPLLoadingProgress) {
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue()) { [weak self] () -> Void in
			guard let strongSelf = self else { return }
			
			// Check to make certain a more recent call to load content hasn't superceded this one…
			if progress.cancelled {
				return
			}
			
			let content = ["This", "is", "a", "basic", "data", "source"]
			
			progress.updateWithContent({ (unused) -> Void in
				strongSelf.items = content
			})
			
		}
	}
	
	override func primaryActionsForItemAtIndexPath(indexPath: NSIndexPath) -> [AAPLAction] {
		return [
			AAPLAction.destructiveActionWithTitle("Delete", selector: Selector("swipeToDeleteCell:")),
			AAPLAction(title: "Action 1", selector: Selector("testSelectorCell:")),
			AAPLAction(title: "Action 2", selector: Selector("testSelectorCell:"))
		]
	}
	
	override func secondaryActionsForItemAtIndexPath(indexPath: NSIndexPath) -> [AAPLAction] {
		return [
			AAPLAction(title: "Favorite", selector: Selector("testSelectorCell:"))
		]
	}
	
	func testSelectorCell(cell: AAPLCollectionViewCell) {
		
	}

}

class ComposedDataSource: AAPLComposedDataSource {
	
	override init() {
		super.init()
		
		let basic1 = self.sectionDataSourceWithTitle("Basic Data Source 1")
		let basic2 = self.sectionDataSourceWithTitle("Basic Data Source 2")
		let basic3 = self.sectionDataSourceWithTitle("Basic Data Source 3")
		
		self.addDataSource(basic1)
		self.addDataSource(basic2)
		self.addDataSource(basic3)
		
		let header2 = self.newHeaderForKey("STICKY_0")
		header2.shouldPin              = false
		header2.shouldStick            = true
		header2.supplementaryViewClass = AAPLSectionHeaderView.self
		header2.backgroundColor        = UIColor(white: 0.9, alpha: 1.0)
		header2.pinnedBackgroundColor  = UIColor(white: 0.9, alpha: 1.0)
		header2.visibleWhileShowingPlaceholder = true
		header2.configureView          = { (reusableView, dataSource, indexPath) -> Void in
			guard let headerView = reusableView as? AAPLSectionHeaderView else { return }
			headerView.leftText = "STICKY_0"
		}
		
		let header1 = self.newHeaderForKey("STICKY_1")
		header1.shouldPin              = true
		header1.shouldStick            = true
		header1.supplementaryViewClass = AAPLSectionHeaderView.self
		header1.backgroundColor        = UIColor(white: 0.9, alpha: 1.0)
		header1.pinnedBackgroundColor  = UIColor(white: 0.5, alpha: 1.0)
		header1.visibleWhileShowingPlaceholder = true
		header1.configureView          = { (reusableView, dataSource, indexPath) -> Void in
			guard let headerView = reusableView as? AAPLSectionHeaderView else { return }
			headerView.leftText = "STICKY_1"
		}
		
		let header5 = self.newHeaderForKey("NORMAL_0")
		header5.shouldPin              = false
		header5.shouldStick            = false
		header5.supplementaryViewClass = AAPLSectionHeaderView.self
		header5.backgroundColor        = UIColor(white: 0.9, alpha: 1.0)
		header5.pinnedBackgroundColor  = UIColor(white: 0.9, alpha: 1.0)
		header5.visibleWhileShowingPlaceholder = true
		header5.configureView          = { (reusableView, dataSource, indexPath) -> Void in
			guard let headerView = reusableView as? AAPLSectionHeaderView else { return }
			headerView.leftText = "NORMAL_0"
		}
		
		let header3 = self.newHeaderForKey("PIN_0")
		header3.shouldPin              = true
		header3.shouldStick            = false
		header3.supplementaryViewClass = AAPLSectionHeaderView.self
		header3.backgroundColor        = UIColor(white: 0.9, alpha: 1.0)
		header3.pinnedBackgroundColor  = UIColor(white: 0.9, alpha: 1.0)
		header3.visibleWhileShowingPlaceholder = true
		header3.configureView          = { (reusableView, dataSource, indexPath) -> Void in
			guard let headerView = reusableView as? AAPLSectionHeaderView else { return }
			headerView.leftText = "PIN_0"
		}
		
		let header4 = self.newHeaderForKey("NORMAL_1")
		header4.shouldPin              = false
		header4.shouldStick            = false
		header4.supplementaryViewClass = AAPLSectionHeaderView.self
		header4.backgroundColor        = UIColor(white: 0.9, alpha: 1.0)
		header4.pinnedBackgroundColor  = UIColor(white: 0.9, alpha: 1.0)
		header4.visibleWhileShowingPlaceholder = true
		header4.configureView          = { (reusableView, dataSource, indexPath) -> Void in
			guard let headerView = reusableView as? AAPLSectionHeaderView else { return }
			headerView.leftText = "NORMAL_1"
		}
		
		let header6 = self.newHeaderForKey("PIN_1")
		header6.shouldPin              = true
		header6.shouldStick            = false
		header6.supplementaryViewClass = AAPLSectionHeaderView.self
		header6.backgroundColor        = UIColor(white: 0.9, alpha: 1.0)
		header6.pinnedBackgroundColor  = UIColor(white: 0.9, alpha: 1.0)
		header6.visibleWhileShowingPlaceholder = true
		header6.configureView          = { (reusableView, dataSource, indexPath) -> Void in
			guard let headerView = reusableView as? AAPLSectionHeaderView else { return }
			headerView.leftText = "PIN_1"
		}
	}
	
	private func sectionDataSourceWithTitle(title: String) -> BasicDataSource {
		let dataSource = BasicDataSource()
		dataSource.title = title
		
		let header = dataSource.newSectionHeader()
		header.shouldPin              = true
		header.supplementaryViewClass = AAPLSectionHeaderView.self
		header.backgroundColor        = UIColor(white: 0.9, alpha: 1.0)
		header.pinnedBackgroundColor  = UIColor(white: 0.9, alpha: 1.0)
		header.configureView          = { (reusableView, dataSource, indexPath) -> Void in
			guard let headerView = reusableView as? AAPLSectionHeaderView else { return }
			headerView.leftText = title
		}
		
		return dataSource
	}
}

class SegmentedDataSource: AAPLSegmentedDataSource {
	
	override init() {
		super.init()
		
		let basic1 = self.basicDataSourceWithTitle("Basic 1")
		let basic2 = self.basicDataSourceWithTitle("Basic 2")
		let basic3 = self.basicDataSourceWithTitle("Basic 3")
		
		self.addDataSource(basic1)
		self.addDataSource(basic2)
		self.addDataSource(basic3)
	}
	
	private func basicDataSourceWithTitle(title: String) -> BasicDataSource {
		let dataSource = BasicDataSource()
		dataSource.title = title
		
		return dataSource
	}
}
