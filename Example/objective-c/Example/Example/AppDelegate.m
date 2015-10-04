//
//  AppDelegate.m
//  Example
//
//  Created by Tamas Dancsi on 04/10/15.
//  Copyright © 2015 Appwoodoo. All rights reserved.
//

#import "AppDelegate.h"
#import <Appwoodoo/Woodoo.h>

NSString *const APPKey = @"<INSERT_YOUR_APP_KEY_HERE>";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     * Push notification support
     * Registering for user notifications
     */
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound|UIUserNotificationTypeAlert|UIUserNotificationTypeBadge) categories:nil];
    [application registerUserNotificationSettings:settings];

    /**
     * Turn Appwoodoo logging on/off
     */
    [Woodoo setHideLogs:NO];

    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

/**
 * Push notification support
 * Gets called if registering was successful
 */

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];

    /**
     * You can set user tags to make Appwoodoo more useful for your marketing campaigns
     * User tags array can be empty, nil or an array full of any objects, but Appwoodoo will only use the NSString objects from it
     * Every tag has to be alphanumeric and shorter than 64 characters, otherwise Appwoodoo will convert it
     */
    NSArray *userTags = @[@"Example", @"Tag"];

    /**
     * Push notification support
     * Registers the device token for the given APPKey with the given user tags
     */
    [Woodoo registerDeviceToken:token withUserTags:userTags forAPPKey:APPKey];
}

/**
 * Push notification support
 * Gets called if registering was unsuccessful
 */

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Registering for push notifications did fail with error: %@", error.localizedDescription);
}

/**
 * Push notification support
 * Gets called if the application received a remote notification
 */

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Remote notification received successfully");

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Great" message:@"Remote notification received successfully" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    [self.window.rootViewController presentViewController:alert animated:TRUE completion:nil];
}

@end
