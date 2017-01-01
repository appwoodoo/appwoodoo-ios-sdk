//
//  WoodooSettingsHandler.h
//  Appwoodoo
//
//  Created by Tamas Dancsi on 17/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * Settings handler is used to store and restore different object types from NSUserDefaults
 */
@interface WoodooSettingsHandler : NSObject

/**
 * Saves given config dictionary to standard user defaults
 * @param config NSDictionary config object
 */
+ (void)saveConfig:(NSDictionary *)config;

/**
 * Removes config from standard user defaults
 */
+ (void)removeConfig;

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
 * Are push notifications enabled?
 * default nil
 */
+ (bool)pushNotificationsEnabled;

/**
 * Set whether push notifications should be enabled
 * @param enabled BOOL enabled flag
 * default nil
 */
+ (void)setPushNotificationsEnabled:(BOOL)enabled;

/**
 * Saves given device token
 * @param token NSString device token string
 */
+ (void)saveDeviceToken:(NSString *)token;

/**
 * Returns the saved device token
 * default nil
 */
+ (NSString *)getDeviceToken;

/**
 * Removes device token from standard user defaults
 */
+ (void)removeDeviceToken;

/**
 * Saves tags
 * @param tags NSArray user tags
 */
+ (void)saveTags:(NSArray *)tags;

/**
 * Returns the saved tags
 * default nil
 */
+ (NSArray *)getTags;

/**
 * Removes tags from standard user defaults
 */
+ (void)removeTags;

/**
 * Returns if Appwoodoo should hide logs
 * default NO
 */
+ (BOOL)shouldHideLogs;

/**
 * Changes if Appwoodoo should hide logs
 * @param hide BOOL hide flag
 */
+ (void)setHideLogs:(BOOL)hide;

/**
 * Gets boolen for key from standard user defaults
 * @param key NSString key string on user defaults
 * @default NO
 */
+ (BOOL)boolForKey:(NSString *)key;

/**
 * Gets string for key from standard user defaults
 * @param key NSString key string on user defaults
 * @default @""
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
