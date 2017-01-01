//
//  WoodooTagHandler.h
//  example
//
//  Created by Tamas Dancsi on 26/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Tag handler is a helper class to handle user tags
 */
@interface WoodooTagHandler : NSObject

/**
 * Returns string from given user tags
 * @param tags NSArray list of user tags
 */
+ (NSString *)tagStringFromArray:(NSArray *)tags;

@end
