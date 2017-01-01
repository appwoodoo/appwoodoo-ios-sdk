//
//  Woodoo.m
//  Appwoodoo
//
//  Created by Tamas Dancsi on 17/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import "Woodoo.h"
#import "WoodooSettingsHandler.h"
#import "WoodooLogHandler.h"
#import "WoodooTagHandler.h"
#import "WoodooApiHandler.h"

@interface Woodoo ()

@property (nonatomic, assign) BOOL needCompletion;
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation Woodoo

+ (Woodoo *)sharedInstance {
    static Woodoo *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

+ (void)takeOff:(NSString *)APPKey {
    [[Woodoo sharedInstance] updateWithKey:APPKey target:nil selector:nil];
    [[Woodoo sharedInstance] downloadSettings];
}

+ (void)takeOff:(NSString *)APPKey target:(id)target selector:(SEL)selector {
    [[Woodoo sharedInstance] updateWithKey:APPKey target:target selector:selector];
    [[Woodoo sharedInstance] downloadSettings];
}

- (void)updateWithKey:(NSString *)woodooKey target:(id)woodooTarget selector:(SEL)woodooSelector {
    [Woodoo sharedInstance].needCompletion = NO;
    if (woodooTarget && woodooSelector) {
        [Woodoo sharedInstance].needCompletion = YES;
    }
    [Woodoo sharedInstance].APPKey = woodooKey;
    [Woodoo sharedInstance].target = woodooTarget;
    [Woodoo sharedInstance].selector = woodooSelector;
    [WoodooSettingsHandler removeConfig];
}

#pragma mark - Logging

+ (void)setHideLogs:(BOOL)hide {
    [WoodooSettingsHandler setHideLogs:hide];
}

#pragma mark - Downloading settings

- (void)downloadSettings {
    WoodooApiHandler *handler = [[WoodooApiHandler alloc] init];
    NSURL *url = [WoodooApiHandler getSettingsEndpoint];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];

    [handler sendRequest:request isJson:NO success:^(NSDictionary *result) {
        [WoodooLogHandler log:@"Appwoodoo: settings retrieved"];
        [WoodooSettingsHandler saveConfig:result];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WoodooArrived" object:nil];
        
        if (self.needCompletion) {
#       pragma clang diagnostic push
#       pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:self.selector];
#       pragma clang diagnostic pop
        }
    } failure:^(NSError *error) {
        [WoodooLogHandler log:[NSString stringWithFormat:@"Appwoodoo: parsing settings error: %@", [error localizedDescription]]];
    }];
}

#pragma mark - Push notifications

+ (bool)pushNotificationsEnabled:(NSString *)woodooKey {
    NSString *savedToken = [WoodooSettingsHandler getDeviceToken];
    if (!savedToken || [savedToken isEqualToString:@""] ||
        !woodooKey || [woodooKey isEqualToString:@""]) {
        return false;
    }
    return [WoodooSettingsHandler pushNotificationsEnabled];
}

+ (void)disablePushNotifications:(NSString *)woodooKey {
    NSString *savedToken = [WoodooSettingsHandler getDeviceToken];
    if (!savedToken || [savedToken isEqualToString:@""] ||
        !woodooKey || [woodooKey isEqualToString:@""]) {
        return;
    }
    [[Woodoo sharedInstance] sendRemoveDeviceToken:savedToken forAPPKey:woodooKey];
}

+ (bool)reEnablePushNotifications:(NSString *)woodooKey {
    NSString *savedToken = [WoodooSettingsHandler getDeviceToken];
    NSArray *savedTags = [WoodooSettingsHandler getTags];
    
    if (!savedToken || [savedToken isEqualToString:@""] ||
        !woodooKey || [woodooKey isEqualToString:@""]) {
        return false;
    }
    [Woodoo registerDeviceToken:savedToken withUserTags:savedTags forAPPKey:woodooKey forced:true];
    return true;
}

#pragma mark - Device token

+ (void)registerDeviceToken:(NSString *)token withUserTags:(NSArray *)tags forAPPKey:(NSString *)woodooKey {
    [Woodoo registerDeviceToken:token withUserTags:tags forAPPKey:woodooKey forced:false];
}

+ (void)registerDeviceToken:(NSString *)token withUserTags:(NSArray *)tags forAPPKey:(NSString *)woodooKey forced:(bool)forced {
    if (!token || [token isEqualToString:@""] ||
        !woodooKey || [woodooKey isEqualToString:@""]) {
        return;
    }
    
    if (forced || [WoodooSettingsHandler pushNotificationsEnabled]) {
        NSString *savedToken = [WoodooSettingsHandler getDeviceToken];
        NSArray *savedTags = [WoodooSettingsHandler getTags];
        if (!forced && savedToken && [savedToken isEqualToString:token] && [savedTags isEqual:tags]) {
            [WoodooLogHandler log:@"Appwoodoo: device token already exists with the same tags, won't send."];
            return;
        }
    } else {
        return;
    }
    
    [[Woodoo sharedInstance] sendDeviceToken:token withUserTags:tags forAPPKey:woodooKey];
}

- (void)sendDeviceToken:(NSString *)token withUserTags:(NSArray *)tags forAPPKey:(NSString *)woodooKey {
    [WoodooSettingsHandler saveDeviceToken:token];
    [WoodooSettingsHandler saveTags:tags];

    NSString *params = [NSString stringWithFormat:@"api_key=%@&dev_id=%@", woodooKey, token];
    NSString *tagString = [WoodooTagHandler tagStringFromArray:tags];
    if (tagString) {
        params = [NSString stringWithFormat:@"api_key=%@&dev_id=%@&tags=%@", woodooKey, token, tagString];
    }
    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [WoodooApiHandler registerForPushEndpoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:requestData];

    WoodooApiHandler *handler = [[WoodooApiHandler alloc] init];
    [handler sendRequest:request isJson:NO success:^(NSDictionary *result) {
        [WoodooLogHandler log:@"Appwoodoo: device token saved"];
        [WoodooSettingsHandler setPushNotificationsEnabled:true];
    } failure:^(NSError *error) {
        [WoodooLogHandler log:[NSString stringWithFormat:@"Appwoodoo: sending device token error: %@", [error localizedDescription]]];
    }];
}

- (void)sendRemoveDeviceToken:(NSString *)token forAPPKey:(NSString *)woodooKey {
    NSURL *url = [WoodooApiHandler removePushEndpoint];
    
    NSString *params = [NSString stringWithFormat:@"api_key=%@&dev_id=%@", woodooKey, token];
    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:requestData];
    
    WoodooApiHandler *handler = [[WoodooApiHandler alloc] init];
    [handler sendRequest:request isJson:NO success:^(NSDictionary *result) {
        [WoodooLogHandler log:@"Appwoodoo: device token removed"];
        [WoodooSettingsHandler setPushNotificationsEnabled:false];
    } failure:^(NSError *error) {
        [WoodooLogHandler log:[NSString stringWithFormat:@"Appwoodoo: removing device token error: %@", [error localizedDescription]]];
    }];
}

#pragma mark - WoodooSettingsHandler

+ (BOOL)isDownloaded {
    return [WoodooSettingsHandler isDownloaded];
}

+ (NSDictionary *)getSettings {
    return [WoodooSettingsHandler getSettings];
}

+ (WoodooStoryViewOptions *)getViewOptions {
    return [WoodooStoriesHandler getViewOptions];
}

+ (BOOL)boolForKey:(NSString *)key {
    return [WoodooSettingsHandler boolForKey:key];
}

+ (NSString *)stringForKey:(NSString *)key {
    return [WoodooSettingsHandler stringForKey:key];
}

+ (NSInteger)integerForKey:(NSString *)key {
    return [WoodooSettingsHandler integerForKey:key];
}

+ (CGFloat)floatForKey:(NSString *)key {
    return [WoodooSettingsHandler floatForKey:key];
}

@end
