//
//  Woodoo.h
//  Appwoodoo
//
//  Created by Tamas Dancsi on 17/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "WoodooLogHandler.h"
#import "WoodooSettingsHandler.h"
#import "WoodooTagHandler.h"
#import "WoodooStoriesHandler.h"
#import "WoodooStoryViewOptions.h"

/**
 * Woodoo is the main interface. It's responsible for:
 *  - Connecting the application and appwooodoo
 *  - Defining an interface for handling push notifications
 *  - Manipulate logging level
 *  - Making settings handling visible publicly
 */
@interface Woodoo : NSObject

/**
 * The application key from appwoodoo
 */
@property (nonatomic, strong) NSString *APPKey;

/**
 * A singleton object, that interacts with appwoodoo
 */
+ (Woodoo *)sharedInstance;

/**
 * Downloads plist config for given APPKey and parses it
 * @param APPKey NSString the appwoodoo key
 */
+ (void)takeOff:(NSString *)APPKey;

/**
 * Downloads plist config for given APPKey and parses it
 * Additionally calls the given selector on the passed target object if they have been set
 * @param APPKey NSString the appwoodoo key
 * @param target id reference to the selector's target object
 * @param selector SEL the callback selector reference
 */
+ (void)takeOff:(NSString *)APPKey target:(id)target selector:(SEL)selector;

#pragma mark - Device token

/**
 * Registers given device token for given APPKey with given user tags (can be nil)
 * @param token NSString the device token string
 * @param tags NSArray list of user tags
 * @param woodooKey NSString the appwoodoo key
 */
+ (void)registerDeviceToken:(NSString *)token withUserTags:(NSArray *)tags forAPPKey:(NSString *)woodooKey;

#pragma mark - Push notifications

/**
 * Shows whether push notifications are enabled for the given APPKey
 * @param woodooKey NSString the appwoodoo key
 */
+ (bool)pushNotificationsEnabled:(NSString *)woodooKey;

/**
 * Disable push notifications (delete the device token from the Appwoodo API)
 * @param woodooKey NSString the appwoodoo key
 */
+ (void)disablePushNotifications:(NSString *)woodooKey;

/**
 * Re-enable a disabled push notification (requires a device token to be stored in the app already)
 * @param woodooKey NSString the appwoodoo key
 */
+ (bool)reEnablePushNotifications:(NSString *)woodooKey;

#pragma mark - Logging

/**
 * Changes if Appwoodoo should hide logs
 * @param hide BOOL hide flag
 */
+ (void)setHideLogs:(BOOL)hide;

#pragma mark - WoodooSettingsHandler

/**
 * Checks if data is downloaded
 */
+ (BOOL)isDownloaded;

/**
 * Returns the saved config dictionary
 * default nil
 */
+ (NSDictionary *)getSettings;

/**
 * Returns the saved view options
 * default empty view options
 */
+ (WoodooStoryViewOptions *)getViewOptions;

/**
 * Gets boolen for key from standard user defaults
 * @param key NSString key string on user defaults
 * @default NO
 */
+ (BOOL)boolForKey:(NSString *)key;

/**
 * Gets string for key from standard user defaults
 * @param key NSString key string on user defaults
 * @default nil
 */
+ (NSString *)stringForKey:(NSString *)key;

/**
 * Gets integer for key from standard user defaults
 * @param key NSString key string on user defaults
 * @default 0
 */
+ (NSInteger)integerForKey:(NSString *)key;

/**
 * Gets float for key from standard user defaults
 * @param key NSString key string on user defaults
 * @default 0
 */
+ (CGFloat)floatForKey:(NSString *)key;

@end
