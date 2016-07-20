//
//  DetailViewController.swift
//  Example
//
//  Created by Pierre-Jean Quillere on 02/07/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

import UIKit
import AdvancedCollectionView


class DetailViewController: AAPLCollectionViewController {
	
	let dataSource = DetailDataSource()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let collectionView = self.collectionView else { return }
		
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

