//
//  WoodooSettingsHandler.h
//  AppWoodoo
//
//  Created by Tamas Dancsi on 18/05/2013.
//  Copyright (c) 2013 AppWoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface WoodooSettingsHandler : NSObject

+ (void)saveConfig:(NSDictionary *)config;
+ (void)removeConfig;
+ (BOOL)isDownloaded;
+ (NSDictionary *)getSettings;
+ (BOOL)boolForKey:(NSString *)key;
+ (NSString *)stringForKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;
+ (CGFloat)floatForKey:(NSString *)key;

@end
