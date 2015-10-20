//
//  AppDelegate.swift
//  Example
//
//  Created by Tamas Dancsi on 04/10/15.
//  Copyright © 2015 Appwoodoo. All rights reserved.
//

import UIKit
import Appwoodoo

struct Constants {
    static let APPKey = "<INSERT_YOUR_APP_KEY_HERE>"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        /**
         * Push notification support
         * Registering for user notifications
         */
        let settings = UIUserNotificationSettings(forTypes: [.Sound, .Alert, .Badge], categories: nil)
        application.registerUserNotificationSettings(settings)

        /**
         * Turn Appwoodoo logging on/off
         */
        Woodoo.setHideLogs(false)

        return true
    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }

    /**
     * Push notification support
     * Gets called if registering was successful
     */

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let set = NSCharacterSet(charactersInString: "<>")
        var token = deviceToken.description.stringByTrimmingCharactersInSet(set)
        token = token.stringByReplacingOccurrencesOfString(" ", withString: "")

        /**
         * You can set user tags to make Appwoodoo more useful for your marketing campaigns
         * User tags array can be empty, nil or an array full of any objects, but Appwoodoo will only use the NSString objects from it
         * Every tag has to be alphanumeric and shorter than 64 characters, otherwise Appwoodoo will convert it
         */
        let userTags = ["Example", "Tag"]

        /**
         * Push notification support
         * Registers the device token for the given APPKey with the given user tags
         */
        Woodoo.registerDeviceToken(token, withUserTags: userTags, forAPPKey: Constants.APPKey)
    }

    /**
     * Push notification support
     * Gets called if registering was unsuccessful
     */

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Registering for push notifications did fail with error: \(error.localizedDescription)")
    }

    /**
     * Push notification support
     * Gets called if the application received a remote notification
     */

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("Remote notification received successfully")
        let alert = UIAlertController(title: "Great", message: "Remote notification received successfully", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(ok)
        self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

}

