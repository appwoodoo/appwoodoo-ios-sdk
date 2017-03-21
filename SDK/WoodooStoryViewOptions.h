//
//  WoodooStoryViewOptions.h
//  develop
//
//  Created by Tamas Dancsi on 21/12/2016.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WoodooStoryViewOptions : NSObject

- (UIColor *)storyWallBackgroundColour;
- (void)setStoryWallBackgroundColour: (UIColor *)colour;

- (UIColor *)storyWallForegroundColour;
- (void)setStoryWallForegroundColour: (UIColor *)colour;

- (UIColor *)storyWallCellDividerColour;
- (void)setStoryWallCellDividerColour: (UIColor *)colour;

- (UIColor *)storyWallCellTitleColour;
- (void)setStoryWallCellTitleColour: (UIColor *)colour;

- (UIColor *)storyWallCellTextColour;
- (void)setStoryWallCellTextColour: (UIColor *)colour;

- (UIColor *)storyWallCellDateColour;
- (void)setStoryWallCellDateColour: (UIColor *)colour;

- (UIFont *)storyWallCellTitleFont;
- (void)setStoryWallCellTitleFont: (UIFont *)font;

- (UIFont *)storyWallCellTextFont;
- (void)setStoryWallCellTextFont: (UIFont *)font;

- (UIFont *)storyWallCellDateFont;
- (void)setStoryWallCellDateFont: (UIFont *)font;

- (int)storyWallCellHeight;
- (void)setStoryWallCellHeight: (int)size;

@end
