//
//  WoodooDialogsHandler.m
//  develop
//
//  Created by Tamas Dancsi on 04/03/2017.
//  Copyright © 2017 Appwoodoo. All rights reserved.
//

#import "WoodooDialogsHandler.h"
#import "WoodooLogHandler.h"
#import "WoodooApiHandler.h"
#import "WoodooDialogView.h"

#define AW_DIALOG_DATA_NAME    @"AppwoodooDialogsData"

@implementation WoodooDialogsHandler

/**
 * Returns all currently available dialogs in an array.
 */
+ (NSArray *)getAvailableDialogs
{
    NSArray *cachedObjects = [WoodooDialogsHandler loadCachedDialogsData];
    NSArray *parsedObjects = [self parseDictionariesToDialogObjects:cachedObjects];

    return parsedObjects;
}

/**
 * Returns a currently available dialogs by its string shorthand
 */
+ (WoodooDialog *)getAvailableDialogByShorthand: (NSString *)shorthand
{
    NSArray *dialogs = [self getAvailableDialogs];
    if (dialogs != nil) {
        for (WoodooDialog *dialog in dialogs) {
            if ([[dialog name] isEqualToString:shorthand]) {
                return dialog;
            }
        }
    }
    return nil;
}

/**
 * Displays the first available dialog (if it hasn't been shown yet)
 */
+ (void)showFirst: (bool)onlyOnce
{
    NSArray *dialogs = [WoodooDialogsHandler getAvailableDialogs];
    if (dialogs == nil || [dialogs count] < 1) {
        return;
    }
    WoodooDialog *dialog = [dialogs firstObject];
    [self show:dialog onlyOnce:onlyOnce];
}

/**
 * Displays a dialog (if it hasn't been shown yet)
 */
+ (void)show: (WoodooDialog *)dialog onlyOnce: (bool)onlyOnce
{
    if (dialog == nil) {
        return;
    }
    [WoodooDialogView showWithWoodooDialog:dialog];
}

+ (NSArray *)parseDictionariesToDialogObjects: (NSArray *)objects
{
    NSMutableArray *newObjects = [[NSMutableArray alloc] init];
    if (objects == nil) {
        return newObjects;
    }

    for (NSDictionary *object in objects) {
        WoodooDialog *dialog = [[WoodooDialog alloc] init];
        
        [dialog setTitle:[object objectForKey:@"title"]];
        [dialog setActionButtonUrl:[object objectForKey:@"action_button_url"]];
        [dialog setActionButtonTitle:[object objectForKey:@"action_button_title"]];
        [dialog setCloseButtonTitle:[object objectForKey:@"close_button_title"]];
        [dialog setBodyText:[object objectForKey:@"body_text"]];
        [dialog setBodyImage:[object objectForKey:@"body_image"]];
        [dialog setName:[object objectForKey:@"name"]];
        
        [newObjects addObject:dialog];
    }

    return newObjects;
}

/**
 * Downloads and returns dialogs from appwoodoo
 * @param success success callback
 * @param failure failure callback
 */
+ (void)getDialogsWithSuccess:(void (^)(NSArray *dialogs))success failure:(void (^)(NSError *error))failure {
    
    WoodooApiHandler *handler = [[WoodooApiHandler alloc] init];
    NSURL *url = [WoodooApiHandler getDialogsEndpoint];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [handler sendRequest:request isJson:YES success:^(NSDictionary *result) {
        if (!result[@"status"] || [result[@"status"] integerValue] != 200) {
            NSError *customError = [NSError errorWithDomain:@"com.appwoodoo.dialogs" code:[result[@"status"] integerValue] userInfo:nil];
            failure(customError);
            return;
        }
        [self cacheDialogsData:result[@"objects"]];
        NSArray *parsedData = [self parseDictionariesToDialogObjects:result[@"objects"]];
        if (success) {
            success(parsedData);
        }
        
    } failure:^(NSError *error) {
        NSArray *cachedDialogs = [self loadCachedDialogsData];
        if (cachedDialogs != nil) {
            success(cachedDialogs);
            return;
        }
        [WoodooLogHandler log:[NSString stringWithFormat:@"Appwoodoo: downloading stories error: %@", [error localizedDescription]]];
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)cacheDialogsData:(NSArray *)data {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:AW_DIALOG_DATA_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)loadCachedDialogsData {
    return [[NSUserDefaults standardUserDefaults] objectForKey:AW_DIALOG_DATA_NAME];
}

@end
