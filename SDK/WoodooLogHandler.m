//
//  WoodooLogHandler.m
//  Appwoodoo
//
//  Created by Tamas Dancsi on 19/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import "WoodooLogHandler.h"
#import "WoodooSettingsHandler.h"

@implementation WoodooLogHandler

+ (void)log:(NSString *)message {
    if ([WoodooSettingsHandler shouldHideLogs]) {
        return;
    }

    NSLog(@"%@", message);
}

@end
