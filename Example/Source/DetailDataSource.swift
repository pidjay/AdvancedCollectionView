//
//  DetailDataSource.swift
//  Example
//
//  Created by Pierre-Jean Quillere on 03/07/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

import UIKit
import AdvancedCollectionView

class DetailDataSource: AAPLBasicDataSource {
	
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
