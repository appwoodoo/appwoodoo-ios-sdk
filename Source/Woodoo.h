//
//  Woodoo.h
//  AppWoodoo
//
//  Created by Tamas Dancsi on 15/05/2013.
//  Copyright (c) 2013 AppWoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Woodoo : NSObject <NSURLConnectionDelegate>

+ (void)takeOff:(NSString *)woodooKey;
+ (void)takeOff:(NSString *)woodooKey target:(id)woodooTarget selector:(SEL)woodooSelector;
+ (NSDictionary *)getSettings;
+ (BOOL)isDownloaded;
+ (BOOL)boolForKey:(NSString *)key;
+ (NSString *)stringForKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;
+ (CGFloat)floatForKey:(NSString *)key;

@end
