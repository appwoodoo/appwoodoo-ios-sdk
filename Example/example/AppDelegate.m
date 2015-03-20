//
//  AppDelegate.m
//  example
//
//  Created by Tamas Dancsi on 16/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
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
#ifdef __IPHONE_8_0
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound|UIUserNotificationTypeAlert|UIUserNotificationTypeBadge) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#else
    UIRemoteNotificationType types = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
#endif

    /**
     * Turn Appwoodoo logging on/off
     */
    [Woodoo setHideLogs:NO];

    return YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}
#endif

/**
 * Push notification support
 * Gets called if registering was successful
 */

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];

    /**
     * Push notification support
     * Registers the device token for the given APPKey
     */
    [Woodoo registerDeviceToken:token forAPPKey:APPKey];
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Great" message:@"Remote notification received successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
