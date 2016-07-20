//
//  DetailViewController.swift
//  Example
//
//  Created by Pierre-Jean Quillere on 02/07/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

import UIKit
import AdvancedCollectionView

enum DataSourceType {
	case Basic
	case Composed
	case Segmented
}

class DetailViewController: AAPLCollectionViewController {
	
	var dataSourceType: DataSourceType?
	
	private var dataSource: AAPLDataSource!
	
	private lazy var basicDataSource     = BasicDataSource()
	private lazy var composedDataSource  = ComposedDataSource()
	private lazy var segmentedDataSource = SegmentedDataSource()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let collectionView = self.collectionView, dataSourceType = self.dataSourceType else { return }
		
		let dataSource: AAPLDataSource
		switch dataSourceType {
		case .Basic:
			dataSource = self.basicDataSource
		case .Composed:
			dataSource = self.composedDataSource
		case .Segmented:
			dataSource = self.segmentedDataSource
		}
		self.dataSource = dataSource
		
		collectionView.dataSource = self.dataSource
		collectionView.backgroundColor = UIColor.whiteColor()
		collectionView.alwaysBounceVertical = true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		guard let text = self.dataSource.itemAtIndexPath(indexPath) as? String else { return }
		print(text)
	}

}

