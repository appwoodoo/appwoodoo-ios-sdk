//
//  WoodooSettingsHandler.h
//  Appwoodoo
//
//  Created by Tamas Dancsi on 17/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface WoodooSettingsHandler : NSObject

/**
 * Saves given config dictionary to standard user defaults
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
 * Saves given device token
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
 */
+ (void)setHideLogs:(BOOL)hide;

/**
 * Gets boolen for key from standard user defaults
 * @default NO
 */
+ (BOOL)boolForKey:(NSString *)key;

/**
 * Gets string for key from standard user defaults
 * @default @""
 */
+ (NSString *)stringForKey:(NSString *)key;

/**
 * Gets integer for key from standard user defaults
 * @default 0
 */
+ (NSInteger)integerForKey:(NSString *)key;

/**
 * Gets float for key from standard user defaults
 * @default 0
 */
+ (CGFloat)floatForKey:(NSString *)key;

@end
