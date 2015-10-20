//
//  VCSettings.swift
//  Example
//
//  Created by Tamas Dancsi on 20/10/15.
//  Copyright © 2015 Appwoodoo. All rights reserved.
//

import UIKit
import Appwoodoo

class VCSettings: UITableViewController {

    var settings = NSDictionary()
    @IBOutlet weak var activityView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onWoodooArrived:", name: "WoodooArrived", object: nil)
        self.launchWoodoo()
    }

    /**
     * Example method to retrieve settings from appwoodoo
     * There are two options, feel free to uncomment/comment the one you'd like to use
     */

    func launchWoodoo() {
        self.activityView.hidden = false

    /**
     * 1. option
     * You can add an observer to a notification named "WoodooArrived"
     * This will be posted everytime, when Appwoodoo downloaded your settings
     */
    //[Woodoo takeOff:APPKey];

    /**
     * 2. option
     * You can call takeOff with a callback method, that will be called when Appwoodoo downloaded your settings
     */
        Woodoo.takeOff(Constants.APPKey, target: self, selector: "woodooCallback")
    }

    @IBAction func onRefreshTap(sender: AnyObject) {
        self.settings = NSDictionary()
        self.tableView.reloadData()
        self.launchWoodoo()
    }

    /**
     * Appwoodoo downloaded your settings - callback handler
     */

    func woodooCallback() {
        self.refreshData()
    }

    /**
     * Appwoodoo downloaded your settings - notification handler
     */

    func onWoodooArrived(notification: NSNotification) {
        self.refreshData()
    }

    /**
     * Refresh table and show your settings
     */

    func refreshData() {
        self.activityView.hidden = true
        self.settings = Woodoo.getSettings() // This is how you can retrieve your settings once they are downloaded
        self.tableView.reloadData()
    }

    // pragma mark - UITableViewDelegate, UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CellSetting"
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }

        let index = indexPath.row
        cell!.textLabel?.text = self.settings.allKeys[index] as? String
        cell!.detailTextLabel?.text = self.settings.allValues[index] as? String

        return cell!
    }

}
