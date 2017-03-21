//
//  WoodooDialogsHandler.h
//  develop
//
//  Created by Tamas Dancsi on 04/03/2017.
//  Copyright © 2017 Appwoodoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WoodooDialog.h"

typedef enum {
    kDialogBackgroundColour,
    kDialogForegroundColour,
} WoodooDialogViewOption;

/**
 * Stories handler implements helper methods to handle appwoodoo stories.
 */
@interface WoodooDialogsHandler : NSObject

/**
 * Returns all currently available dialogs in an array.
 */
+ (NSArray *)getAvailableDialogs;

/**
 * Returns a currently available dialogs by its string shorthand
 */
+ (WoodooDialog *)getAvailableDialogByShorthand: (NSString *)shorthand;

/**
 * Displays the first available dialog (if it hasn't been shown yet)
 */
+ (void)showFirst: (bool)onlyOnce;

/**
 * Displays a dialog (if it hasn't been shown yet)
 */
+ (void)show: (WoodooDialog *)dialog onlyOnce: (bool)onlyOnce;

/**
 * Downloads and returns dialogs from appwoodoo
 * @param success success callback
 * @param failure failure callback
 */
+ (void)getDialogsWithSuccess:(void (^)(NSArray *dialogs))success failure:(void (^)(NSError *error))failure;

@end
