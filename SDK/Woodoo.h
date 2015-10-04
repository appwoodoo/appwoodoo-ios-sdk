//
//  Woodoo.h
//  Appwoodoo
//
//  Created by Tamas Dancsi on 17/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Woodoo : NSObject <NSURLConnectionDelegate>

/**
 * @function takeOff
 * Downloads plist config for given APPKey and parses it
 */
+ (void)takeOff:(NSString *)APPKey;

/**
 * @function takeOff
 * Downloads plist config for given APPKey and parses it
 * Additionally calls the given selector on the passed target object if they have been set
 */
+ (void)takeOff:(NSString *)APPKey target:(id)target selector:(SEL)selector;

/**
 * @function registerDeviceToken
 * Registers given device token for given APPKey with given user tags (can be nil)
 */
+ (void)registerDeviceToken:(NSString *)token withUserTags:(NSArray *)tags forAPPKey:(NSString *)woodooKey;

/**
 * Changes if Appwoodoo should hide logs
 */
+ (void)setHideLogs:(BOOL)hide;

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
 * Gets boolen for key from standard user defaults
 * @default NO
 */
+ (BOOL)boolForKey:(NSString *)key;

/**
 * Gets string for key from standard user defaults
 * @default nil
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
