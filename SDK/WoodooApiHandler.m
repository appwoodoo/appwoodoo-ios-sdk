//
//  WoodooApiHandler.m
//  develop
//
//  Created by Tamas Dancsi on 23/09/16.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import "WoodooApiHandler.h"
#import "Woodoo.h"

NSString *const API_ENDPOINT = @"https://www.appwoodoo.com/api/v1";

@interface WoodooApiHandler () <NSURLConnectionDelegate>

@property (nonatomic, assign) BOOL isJson;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, copy) void (^success)(NSDictionary *result);
@property (nonatomic, copy) void (^failure)(NSError *error);

@end

@implementation WoodooApiHandler

- (void)sendRequest:(NSURLRequest *)request isJson:(BOOL)isJson success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure {
    self.success = success;
    self.failure = failure;
    self.isJson = isJson;
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)received {
    [self.data appendData:received];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *error;
    id result;
    if (self.isJson) {
        result = [NSJSONSerialization JSONObjectWithData:self.data options:kNilOptions error:&error];
    } else {
        NSPropertyListFormat format;
        result = [NSPropertyListSerialization propertyListWithData:self.data options:NSPropertyListImmutable format:&format error:&error];
    }
    if (error) {
        self.failure(error);
        return;
    }
    self.success(result);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [WoodooLogHandler log:[NSString stringWithFormat:@"Appoodoo: download error: %@", [error localizedDescription]]];
    self.failure(error);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

#pragma mark - Endpoints

+ (NSURL *)getSettingsEndpoint {
    NSString *urlString = [NSString stringWithFormat:@"%@/settings/%@.plist", API_ENDPOINT, [Woodoo sharedInstance].APPKey];
    return [NSURL URLWithString:urlString];
}

+ (NSURL *)registerForPushEndpoint {
    NSString *urlString = [NSString stringWithFormat:@"%@/push/ios/register/", API_ENDPOINT];
    return [NSURL URLWithString:urlString];
}

+ (NSURL *)removePushEndpoint {
    NSString *urlString = [NSString stringWithFormat:@"%@/push/ios/remove/", API_ENDPOINT];
    return [NSURL URLWithString:urlString];
}

+ (NSURL *)getStoriesEndpoint {
    NSString *urlString = [NSString stringWithFormat:@"%@/stories/%@/", API_ENDPOINT, [Woodoo sharedInstance].APPKey];
    return [NSURL URLWithString:urlString];
}

@end
