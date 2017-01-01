//
//  WoodooApiHandler.h
//  develop
//
//  Created by Tamas Dancsi on 23/09/16.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The api handler. Sends requests to appwoodoo and handles its responses.
 */
@interface WoodooApiHandler : NSObject

/**
 * Sends a given request to appwooodoo then calls the success or failure callbacks
 * @param request the request object, that will be sent
 * @param isJson BOOL json responses can be handled differently
 * @param success success callback
 * @param failure failure callback
 */
- (void)sendRequest:(NSURLRequest *)request isJson:(BOOL)isJson success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;
    
#pragma mark - Endpoints

/**
 * Returns endpoint for getting woodoo settings
 */
+ (NSURL *)getSettingsEndpoint;

/**
 * Returns endpoint for registering device token for push notifications
 */
+ (NSURL *)registerForPushEndpoint;

/**
 * Returns endpoint for removing device token for push notifications
 */
+ (NSURL *)removePushEndpoint;

/**
 * Returns endpoint for getting woodoo stories
 */
+ (NSURL *)getStoriesEndpoint;

@end
