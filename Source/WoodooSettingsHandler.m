//
//  WoodooSettingsHandler.m
//  AppWoodoo
//
//  Created by Tamas Dancsi on 18/05/2013.
//  Copyright (c) 2013 AppWoodoo. All rights reserved.
//

#import "WoodooSettingsHandler.h"
#define CONFIGNAME @"AppWoodooSetting"

@interface WoodooSettingsHandler ()

+ (id)objectForKey:(NSString *)key;

@end

@implementation WoodooSettingsHandler

/**
 * Saves given config dictionary to userdefaults
 */

+ (void)saveConfig:(NSDictionary *)config
{
    [[NSUserDefaults standardUserDefaults] setObject:config forKey:CONFIGNAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 * Removes config from userdefaults
 */

+ (void)removeConfig
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:CONFIGNAME];
}

/**
 * Gets value for given key in userdefaults
 */

+ (id)objectForKey:(NSString *)key
{
    NSDictionary *config = [[NSUserDefaults standardUserDefaults] dictionaryForKey:CONFIGNAME];
    if (!config) {
        return nil;
    }

    return config[key];
}

/**
 * Returns the saved config dictionary
 * default nil
 */

+ (NSDictionary *)getSettings
{
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:CONFIGNAME];
}

/**
 * Checks if data is downloaded
 */

+ (BOOL)isDownloaded
{
    NSDictionary *config = [[NSUserDefaults standardUserDefaults] dictionaryForKey:CONFIGNAME];
    if (!config) {
        return NO;
    }
    return YES;
}

/**
 * Gets boolen for key from userdefaults
 * @default NO
 */

+ (BOOL)boolForKey:(NSString *)key
{
    NSNumber *object = [WoodooSettingsHandler objectForKey:key];
    NSInteger result = 0;
    if (object) {
        result = [object boolValue];
    }
    return result;
}

/**
 * Gets string for key from userdefaults
 * @default @""
 */

+ (NSString *)stringForKey:(NSString *)key
{
    NSString *string = @"";
    NSString *object = [WoodooSettingsHandler objectForKey:key];
    if (object) {
        string = object;
    }    
    return string;
}

/**
 * Gets integer for key from userdefaults
 * @default 0
 */

+ (NSInteger)integerForKey:(NSString *)key
{
    NSNumber *object = [WoodooSettingsHandler objectForKey:key];
    NSInteger result = 0;
    if (object) {
        result = [object integerValue];
    }
    return result;
}

/**
 * Gets float for key from userdefaults
 * @default 0
 */

+ (CGFloat)floatForKey:(NSString *)key
{
    NSNumber *object = [WoodooSettingsHandler objectForKey:key];
    NSInteger result = 0;
    if (object) {
        result = [object floatValue];
    }
    return result;
}

@end
