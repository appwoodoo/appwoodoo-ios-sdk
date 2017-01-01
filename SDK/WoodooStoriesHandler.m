//
//  WoodooStoriesHandler.m
//  develop
//
//  Created by Tamas Dancsi on 23/09/16.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import "WoodooStoriesHandler.h"
#import "WoodooLogHandler.h"
#import "WoodooApiHandler.h"

#define AW_STORY_CONFIG_NAME  @"AppwoodooStorySettings"
#define AW_STORY_DATA_NAME    @"AppwoodooStoryData"

@implementation WoodooStoriesHandler

+ (WoodooStoriesNavigationController *)woodooStoriesNavigationController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WoodooStories" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:@"WoodooStoriesNavigationController"];
}

+ (WoodooStoriesListViewController *)woodooStoriesListViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WoodooStories" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:@"WoodooStoriesListViewController"];;
}

/**
 * View options are stored in NSUserDefaults, we decode them here
 */
+ (WoodooStoryViewOptions *)getViewOptions
{
    WoodooStoryViewOptions *viewOptions = [[WoodooStoryViewOptions alloc] init];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:AW_STORY_CONFIG_NAME];
    
    NSData *storyWallBackgroundColour = [dict objectForKey:@"kStoryWallBackgroundColour"];
    if (storyWallBackgroundColour != nil) {
        UIColor *colour = [NSKeyedUnarchiver unarchiveObjectWithData:storyWallBackgroundColour];
        [viewOptions setStoryWallBackgroundColour:colour];
    }

    NSData *storyWallForegroundColour = [dict objectForKey:@"kStoryWallForegroundColour"];
    if (storyWallForegroundColour != nil) {
        UIColor *colour = [NSKeyedUnarchiver unarchiveObjectWithData:storyWallForegroundColour];
        [viewOptions setStoryWallForegroundColour:colour];
    }

    NSData *storyWallCellDividerColour = [dict objectForKey:@"kStoryWallCellDividerColour"];
    if (storyWallCellDividerColour != nil) {
        UIColor *colour = [NSKeyedUnarchiver unarchiveObjectWithData:storyWallCellDividerColour];
        [viewOptions setStoryWallCellDividerColour:colour];
    }

    NSData *storyWallCellTitleColour = [dict objectForKey:@"kStoryWallCellTitleColour"];
    if (storyWallCellTitleColour != nil) {
        UIColor *colour = [NSKeyedUnarchiver unarchiveObjectWithData:storyWallCellTitleColour];
        [viewOptions setStoryWallCellTitleColour:colour];
    }

    NSData *storyWallCellTextColour = [dict objectForKey:@"kStoryWallCellTextColour"];
    if (storyWallCellTextColour != nil) {
        UIColor *colour = [NSKeyedUnarchiver unarchiveObjectWithData:storyWallCellTextColour];
        [viewOptions setStoryWallCellTextColour:colour];
    }

    NSData *storyWallCellDateColour = [dict objectForKey:@"kStoryWallCellDateColour"];
    if (storyWallCellDateColour != nil) {
        UIColor *colour = [NSKeyedUnarchiver unarchiveObjectWithData:storyWallCellDateColour];
        [viewOptions setStoryWallCellDateColour:colour];
    }

    NSData *storyWallCellTitleFont = [dict objectForKey:@"kStoryWallCellTitleFont"];
    if (storyWallCellTitleFont != nil) {
        UIFont *font = [NSKeyedUnarchiver unarchiveObjectWithData:storyWallCellTitleFont];
        [viewOptions setStoryWallCellTitleFont:font];
    }

    NSData *storyWallCellTextFont = [dict objectForKey:@"kStoryWallCellTextFont"];
    if (storyWallCellTextFont != nil) {
        UIFont *font = [NSKeyedUnarchiver unarchiveObjectWithData:storyWallCellTextFont];
        [viewOptions setStoryWallCellTextFont:font];
    }

    NSData *storyWallCellDateFont = [dict objectForKey:@"kStoryWallCellDateFont"];
    if (storyWallCellDateFont != nil) {
        UIFont *font = [NSKeyedUnarchiver unarchiveObjectWithData:storyWallCellDateFont];
        [viewOptions setStoryWallCellDateFont:font];
    }

    NSNumber *storyWallCellHeight = [dict objectForKey:@"kStoryWallCellHeight"];
    if (storyWallCellHeight != nil) {
        [viewOptions setStoryWallCellHeight:[storyWallCellHeight intValue]];
    }
    
    return viewOptions;
}

/**
 * Sets a colour view option for the story wall to use
 */
+ (void)setViewOption:(WoodooStoryWallViewOption)viewOption color: (UIColor *)color
{
    WoodooStoryViewOptions *viewOptions = [self getViewOptions];
    
    switch (viewOption) {
        case kStoryWallBackgroundColour:
            [viewOptions setStoryWallBackgroundColour:color];
            break;

        case kStoryWallForegroundColour:
            [viewOptions setStoryWallForegroundColour:color];
            break;
            
        case kStoryWallCellDateColour:
            [viewOptions setStoryWallCellDateColour:color];
            break;
            
        case kStoryWallCellTextColour:
            [viewOptions setStoryWallCellTextColour:color];
            break;
            
        case kStoryWallCellTitleColour:
            [viewOptions setStoryWallCellTitleColour:color];
            break;
            
        case kStoryWallCellDividerColour:
            [viewOptions setStoryWallCellDividerColour:color];
            break;

        default:
            // We don't want to save non-colour values
            return;
    }
    
    [self setViewOptions:viewOptions];
}

/**
 * Sets a numeric view option for the story wall to use
 */
+ (void)setViewOption:(WoodooStoryWallViewOption)viewOption size: (int)size
{
    WoodooStoryViewOptions *viewOptions = [self getViewOptions];

    switch (viewOption) {
        case kStoryWallCellHeight:
            [viewOptions setStoryWallCellHeight:size];
            break;
            
        default:
            // We don't want to save non-int values
            return;
    }

    [self setViewOptions:viewOptions];
}

/**
 * Sets a font view option for the story wall to use
 */
+ (void)setViewOption: (WoodooStoryWallViewOption)viewOption font: (UIFont *)font
{
    WoodooStoryViewOptions *viewOptions = [self getViewOptions];

    switch (viewOption) {
        case kStoryWallCellTitleFont:
            [viewOptions setStoryWallCellTitleFont:font];
            break;
            
        case kStoryWallCellTextFont:
            [viewOptions setStoryWallCellTextFont:font];
            break;
            
        case kStoryWallCellDateFont:
            [viewOptions setStoryWallCellDateFont:font];
            break;
            
        default:
            // We don't want to save non-int values
            return;
    }

    [self setViewOptions:viewOptions];
}

/**
 * View options are stored in NSUserDefaults, we encode them here
 */
+ (void)setViewOptions:(WoodooStoryViewOptions *)viewOptions
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:AW_STORY_CONFIG_NAME];
    
    NSMutableDictionary *mutableDict = [dict mutableCopy];
    
    if (dict == nil) {
        mutableDict = [[NSMutableDictionary alloc] init];
    }
    
    NSData *storyWallBackgroundColour = [NSKeyedArchiver archivedDataWithRootObject:[viewOptions storyWallBackgroundColour]];
    [mutableDict setObject:storyWallBackgroundColour forKey:@"kStoryWallBackgroundColour"];
    
    NSData *storyWallForegroundColour = [NSKeyedArchiver archivedDataWithRootObject:[viewOptions storyWallForegroundColour]];
    [mutableDict setObject:storyWallForegroundColour forKey:@"kStoryWallForegroundColour"];

    NSData *storyWallCellDividerColour = [NSKeyedArchiver archivedDataWithRootObject:[viewOptions storyWallCellDividerColour]];
    [mutableDict setObject:storyWallCellDividerColour forKey:@"kStoryWallCellDividerColour"];

    NSData *storyWallCellTitleColour = [NSKeyedArchiver archivedDataWithRootObject:[viewOptions storyWallCellTitleColour]];
    [mutableDict setObject:storyWallCellTitleColour forKey:@"kStoryWallCellTitleColour"];

    NSData *storyWallCellTextColour = [NSKeyedArchiver archivedDataWithRootObject:[viewOptions storyWallCellTextColour]];
    [mutableDict setObject:storyWallCellTextColour forKey:@"kStoryWallCellTextColour"];

    NSData *storyWallCellDateColour = [NSKeyedArchiver archivedDataWithRootObject:[viewOptions storyWallCellDateColour]];
    [mutableDict setObject:storyWallCellDateColour forKey:@"kStoryWallCellDateColour"];

    NSData *storyWallCellTitleFont = [NSKeyedArchiver archivedDataWithRootObject:[viewOptions storyWallCellTitleFont]];
    [mutableDict setObject:storyWallCellTitleFont forKey:@"kStoryWallCellTitleFont"];

    NSData *storyWallCellTextFont = [NSKeyedArchiver archivedDataWithRootObject:[viewOptions storyWallCellTextFont]];
    [mutableDict setObject:storyWallCellTextFont forKey:@"kStoryWallCellTextFont"];

    NSData *storyWallCellDateFont = [NSKeyedArchiver archivedDataWithRootObject:[viewOptions storyWallCellDateFont]];
    [mutableDict setObject:storyWallCellDateFont forKey:@"kStoryWallCellDateFont"];

    NSNumber *storyWallCellHeight = [NSNumber numberWithInt:[viewOptions storyWallCellHeight]];
    [mutableDict setObject:storyWallCellHeight forKey:@"kStoryWallCellHeight"];

    [[NSUserDefaults standardUserDefaults] setObject:mutableDict forKey:AW_STORY_CONFIG_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)getStoryWallWithSuccess:(void (^)(NSDictionary *storyWall))success failure:(void (^)(NSError *error))failure {

    WoodooApiHandler *handler = [[WoodooApiHandler alloc] init];
    NSURL *url = [WoodooApiHandler getStoriesEndpoint];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [handler sendRequest:request isJson:YES success:^(NSDictionary *result) {
        if (!result[@"status"] || [result[@"status"] integerValue] != 200) {
            NSError *customError = [NSError errorWithDomain:@"com.appwoodoo.stories" code:[result[@"status"] integerValue] userInfo:nil];
            failure(customError);
            return;
        }
        [self cacheStoryWallData:result];
        success(result[@"story_wall"]);

    } failure:^(NSError *error) {
        NSDictionary *cachedStoryWall = [self loadCachedStoryWallData];
        if (cachedStoryWall != nil) {
            success(cachedStoryWall[@"story_wall"]);
            return;
        }
        [WoodooLogHandler log:[NSString stringWithFormat:@"Appwoodoo: downloading stories error: %@", [error localizedDescription]]];
        failure(error);
    }];
}

+ (void)cacheStoryWallData:(NSDictionary *)config {
    [[NSUserDefaults standardUserDefaults] setObject:config forKey:AW_STORY_DATA_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDictionary *)loadCachedStoryWallData {
    return [[NSUserDefaults standardUserDefaults] objectForKey:AW_STORY_DATA_NAME];
}

@end
