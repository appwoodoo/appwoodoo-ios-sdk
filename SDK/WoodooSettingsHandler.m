//
//  WoodooSettingsHandler.m
//  Appwoodoo
//
//  Created by Tamas Dancsi on 17/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import "WoodooSettingsHandler.h"

#define AW_CONFIG_NAME @"AppwoodooSetting"
#define AW_DEVICE_TOKEN_NAME @"AppwoodooDeviceToken"
#define AW_HIDE_LOG_NAME @"AppwoodooHideLogs"
#define AW_TAG_NAME @"AppwoodooTags"
#define AW_PN_ENABLED_NAME @"AppwoodooPushNotificationEnabled"

@interface WoodooSettingsHandler ()

+ (id)objectForKey:(NSString *)key;

@end

@implementation WoodooSettingsHandler

+ (void)saveConfig:(NSDictionary *)config {
    [[NSUserDefaults standardUserDefaults] setObject:config forKey:AW_CONFIG_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeConfig {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:AW_CONFIG_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForKey:(NSString *)key {
    NSDictionary *config = [[NSUserDefaults standardUserDefaults] dictionaryForKey:AW_CONFIG_NAME];
    if (!config) {
        return nil;
    }
    return config[key];
}

+ (NSDictionary *)getSettings {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:AW_CONFIG_NAME];
}

+ (bool)pushNotificationsEnabled {
    NSNumber *enabled = [[NSUserDefaults standardUserDefaults] objectForKey:AW_PN_ENABLED_NAME];

    // If the user hasn't explicitly switched the notifications off, they are
    // switched on! (Otherwise we wouldn't be here: this function is only called
    // if we do have a device token but unsure whether the user wants to send it)
    if (enabled == nil) {
        return true;
    }
    
    return enabled.boolValue;
}

+ (void)setPushNotificationsEnabled:(bool)enabled {
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:enabled] forKey:AW_PN_ENABLED_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveDeviceToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:AW_DEVICE_TOKEN_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getDeviceToken {
    return [[NSUserDefaults standardUserDefaults] stringForKey:AW_DEVICE_TOKEN_NAME];
}

+ (void)removeDeviceToken {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:AW_DEVICE_TOKEN_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveTags:(NSArray *)tags {
    [[NSUserDefaults standardUserDefaults] setObject:tags forKey:AW_TAG_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)getTags {
    return [[NSUserDefaults standardUserDefaults] objectForKey:AW_TAG_NAME];
}

+ (void)removeTags {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:AW_TAG_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)shouldHideLogs {
    return [[NSUserDefaults standardUserDefaults] boolForKey:AW_HIDE_LOG_NAME];
}

+ (void)setHideLogs:(BOOL)hide {
    [[NSUserDefaults standardUserDefaults] setBool:hide forKey:AW_HIDE_LOG_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isDownloaded {
    NSDictionary *config = [[NSUserDefaults standardUserDefaults] dictionaryForKey:AW_CONFIG_NAME];
    if (!config) {
        return NO;
    }
    return YES;
}

+ (BOOL)boolForKey:(NSString *)key {
    NSNumber *object = [WoodooSettingsHandler objectForKey:key];
    NSInteger result = 0;
    if (object) {
        result = [object boolValue];
    }
    return result;
}

+ (NSString *)stringForKey:(NSString *)key {
    NSString *string = @"";
    NSString *object = [WoodooSettingsHandler objectForKey:key];
    if (object) {
        string = object;
    }    
    return string;
}

+ (NSInteger)integerForKey:(NSString *)key {
    NSNumber *object = [WoodooSettingsHandler objectForKey:key];
    NSInteger result = 0;
    if (object) {
        result = [object integerValue];
    }
    return result;
}

+ (CGFloat)floatForKey:(NSString *)key {
    NSNumber *object = [WoodooSettingsHandler objectForKey:key];
    NSInteger result = 0;
    if (object) {
        result = [object floatValue];
    }
    return result;
}

@end
