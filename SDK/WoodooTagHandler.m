//
//  WoodooTagHandler.m
//  example
//
//  Created by Tamas Dancsi on 26/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import "WoodooTagHandler.h"
#import "WoodooLogHandler.h"

@implementation WoodooTagHandler

+ (NSString *)tagStringFromArray:(NSArray *)tags {
    if (!tags) {
        return nil;
    }

    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString *validTag;
    for (id tagObject in tags) {
        if (![tagObject isKindOfClass:[NSString class]]) {
            [WoodooLogHandler log:[NSString stringWithFormat:@"Appwoodoo warning: tag is not NSString: %@", tagObject]];
            continue;
        }

        NSString *tag = tagObject;
        validTag = [WoodooTagHandler validTag:tag];
        if (validTag) {
            [result addObject:validTag];
        }
        else {
            [WoodooLogHandler log:[NSString stringWithFormat:@"Appwoodoo warning: invalid tag: %@", tag]];
        }
    }

    return result.count > 0 ? [result componentsJoinedByString:@","] : nil;
}

+ (NSString *)validTag:(NSString *)tag {
    tag = [[tag componentsSeparatedByCharactersInSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]] componentsJoinedByString:@""];

    NSInteger max = 64;
    if (tag.length > max) {
        tag = [tag substringToIndex:max];
    }

    return tag.length == 0 ? nil : tag;
}

@end
