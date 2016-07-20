//
//  MasterViewController.swift
//  Example
//
//  Created by Pierre-Jean Quillere on 02/07/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

	var detailViewController: DetailViewController? = nil
	var objects = [AnyObject]()


	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
	}

	override func viewWillAppear(animated: Bool) {
		self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
		super.viewWillAppear(animated)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Segues

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showDetail" {
//		    if let indexPath = self.tableView.indexPathForSelectedRow {
//		        let object = objects[indexPath.row] as! NSDate
//		        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//		        controller.detailItem = object
//		        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//		        controller.navigationItem.leftItemsSupplementBackButton = true
//		    }
		}
	}

}

