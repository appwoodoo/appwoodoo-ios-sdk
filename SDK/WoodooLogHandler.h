//
//  WoodooLogHandler.h
//  Appwoodoo
//
//  Created by Tamas Dancsi on 19/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The log handler. Logs only if logging is enabled. Uses NSLog.
 */
@interface WoodooLogHandler : NSObject

/**
 * Logs message to the console output if logs are enabled
 * @param message NSString the message to log
 */
+ (void)log:(NSString *)message;

@end
