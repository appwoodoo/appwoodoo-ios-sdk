//
//  Woodoo.m
//  AppWoodoo
//
//  Created by Tamas Dancsi on 15/05/2013.
//  Copyright (c) 2013 AppWoodoo. All rights reserved.
//

#import "Woodoo.h"
#import "WoodooSettingsHandler.h"

@interface Woodoo () {
    NSString *APIKey;
    NSMutableData *responseData;
    BOOL needCompletion;
    id target;
    SEL selector;
}

- (id)initWithKey:(NSString *)woodooKey target:(id)woodooTarget selector:(SEL)woodooSelector;
- (void)startDownload;

@end

@implementation Woodoo

/**
 * @function takeOff
 * Downloads plist config for given APIKey and parses it
 */

+ (void)takeOff:(NSString *)woodooKey
{
    Woodoo *woodoo = [[Woodoo alloc] initWithKey:woodooKey target:nil selector:nil];
    [woodoo startDownload];
}

/**
 * @function takeOff
 * With callback selector
 */

+ (void)takeOff:(NSString *)woodooKey target:(id)woodooTarget selector:(SEL)woodooSelector
{
    Woodoo *woodoo = [[Woodoo alloc] initWithKey:woodooKey target:woodooTarget selector:woodooSelector];
    [woodoo startDownload];
}

/**
 * @function takeOff
 * With callback selector
 */

- (id)initWithKey:(NSString *)woodooKey target:(id)woodooTarget selector:(SEL)woodooSelector
{
    self = [super init];
    if (self) {
        needCompletion = NO;
        if (woodooTarget && woodooSelector) {
            needCompletion = YES;
        }

        APIKey = woodooKey;
        target = woodooTarget;
        selector = woodooSelector;

        [WoodooSettingsHandler removeConfig];
    }
    return self;
}

/**
 * @function startDownload
 * Downloads settings
 */

- (void)startDownload
{
    NSString *urlString = [NSString stringWithFormat:@"http://www.appwoodoo.com/api/v1/settings/%@.plist", APIKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

/**
 * Checks if data is downloaded
 */

+ (BOOL)isDownloaded
{
    return [WoodooSettingsHandler isDownloaded];
}

/**
 * Returns the saved config dictionary
 * default nil
 */

+ (NSDictionary *)getSettings
{
    return [WoodooSettingsHandler getSettings];
}

/**
 * Gets boolen for key from userdefaults
 * @default NO
 */

+ (BOOL)boolForKey:(NSString *)key
{
    return [WoodooSettingsHandler boolForKey:key];
}

/**
 * Gets string for key from userdefaults
 * @default nil
 */

+ (NSString *)stringForKey:(NSString *)key
{
    return [WoodooSettingsHandler stringForKey:key];
}

/**
 * Gets integer for key from userdefaults
 * @default 0
 */

+ (NSInteger)integerForKey:(NSString *)key
{
    return [WoodooSettingsHandler integerForKey:key];
}

/**
 * Gets float for key from userdefaults
 * @default 0
 */

+ (CGFloat)floatForKey:(NSString *)key
{
    return [WoodooSettingsHandler floatForKey:key];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *errorDescription;
    NSPropertyListFormat format;
    NSDictionary *result = [NSPropertyListSerialization propertyListFromData:responseData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&errorDescription];
    if (errorDescription) {
        NSLog(@"Woodoo parse error: %@", errorDescription);
    }

    [WoodooSettingsHandler saveConfig:result];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WoodooArrived" object:nil];

    if (needCompletion) {
#       pragma clang diagnostic push
#       pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:selector];
#       pragma clang diagnostic pop
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Woodoo download error: %@", [error localizedDescription]);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}

@end
