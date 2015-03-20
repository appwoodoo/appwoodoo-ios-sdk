//
//  WoodooSettingsHandler.m
//  Appwoodoo
//
//  Created by Tamas Dancsi on 17/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import "WoodooSettingsHandler.h"

#define CONFIG_NAME @"AppwoodooSetting"
#define DEVICE_TOKEN_NAME @"AppwoodooDeviceToken"
#define HIDE_LOG_NAME @"AppwoodooHideLogs"

@interface WoodooSettingsHandler ()

+ (id)objectForKey:(NSString *)key;

@end

@implementation WoodooSettingsHandler

+ (void)saveConfig:(NSDictionary *)config {
    [[NSUserDefaults standardUserDefaults] setObject:config forKey:CONFIG_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeConfig {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:CONFIG_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForKey:(NSString *)key {
    NSDictionary *config = [[NSUserDefaults standardUserDefaults] dictionaryForKey:CONFIG_NAME];
    if (!config) {
        return nil;
    }
    return config[key];
}

+ (NSDictionary *)getSettings {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:CONFIG_NAME];
}

+ (void)saveDeviceToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:DEVICE_TOKEN_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getDeviceToken {
    return [[NSUserDefaults standardUserDefaults] stringForKey:DEVICE_TOKEN_NAME];
}

+ (void)removeDeviceToken {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DEVICE_TOKEN_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)shouldHideLogs {
    return [[NSUserDefaults standardUserDefaults] boolForKey:HIDE_LOG_NAME];
}

+ (void)setHideLogs:(BOOL)hide {
    [[NSUserDefaults standardUserDefaults] setBool:hide forKey:HIDE_LOG_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isDownloaded {
    NSDictionary *config = [[NSUserDefaults standardUserDefaults] dictionaryForKey:CONFIG_NAME];
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
