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
