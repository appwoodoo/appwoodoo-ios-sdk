//
//  WoodooStoriesHandler.h
//  develop
//
//  Created by Tamas Dancsi on 23/09/16.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WoodooStoriesNavigationController.h"
#import "WoodooStoriesListViewController.h"
#import "WoodooStoryViewOptions.h"

typedef enum {
    kStoryWallBackgroundColour,
    kStoryWallForegroundColour,
    kStoryWallCellDividerColour,
    kStoryWallCellTitleColour,
    kStoryWallCellTextColour,
    kStoryWallCellDateColour,
    kStoryWallCellTitleFont,
    kStoryWallCellTextFont,
    kStoryWallCellDateFont,
    kStoryWallCellHeight
} WoodooStoryWallViewOption;

/**
 * Stories handler implements helper methods to handle appwoodoo stories.
 */
@interface WoodooStoriesHandler : NSObject

/**
 * Returns an instance inherited from UINavigationController, that loads stories from woodoo
 */
+ (WoodooStoriesNavigationController *)woodooStoriesNavigationController;

/**
 * Returns an instance inherited from UITableViewController, that loads stories from woodoo
 */
+ (WoodooStoriesListViewController *)woodooStoriesListViewController;

/**
 * Returns the story wall's view options to use; it may be new, cached or default values
 */
+ (WoodooStoryViewOptions *)getViewOptions;

/**
 * Sets a colour view option for the story wall to use
 */
+ (void)setViewOption: (WoodooStoryWallViewOption)viewOption color: (UIColor *)color;

/**
 * Sets a numeric view option for the story wall to use
 */
+ (void)setViewOption: (WoodooStoryWallViewOption)viewOption size: (int)size;

/**
 * Sets a font view option for the story wall to use
 */
+ (void)setViewOption: (WoodooStoryWallViewOption)viewOption font: (UIFont *)font;

/**
 * Downloads and returns stories from appwoodoo
 * @param success success callback
 * @param failure failure callback
 */
+ (void)getStoryWallWithSuccess:(void (^)(NSDictionary *storyWall))success failure:(void (^)(NSError *error))failure;

@end
