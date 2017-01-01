//
//  WoodooStoryViewOptions.m
//  develop
//
//  Created by Richard Dancsi on 21/12/2016.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import "WoodooStoryViewOptions.h"

@implementation WoodooStoryViewOptions {
    UIColor *_storyWallBackgroundColour;
    UIColor *_storyWallForegroundColour;
    UIColor *_storyWallCellDividerColour;
    UIColor *_storyWallCellTitleColour;
    UIColor *_storyWallCellTextColour;
    UIColor *_storyWallCellDateColour;
    UIFont *_storyWallCellTitleFont;
    UIFont *_storyWallCellTextFont;
    UIFont *_storyWallCellDateFont;
    NSNumber *_storyWallCellHeight;
}

- (UIColor *)storyWallBackgroundColour
{
    if (_storyWallBackgroundColour != nil) {
        return _storyWallBackgroundColour;
    }
    return [UIColor whiteColor];
}

- (void)setStoryWallBackgroundColour: (UIColor *)colour
{
    _storyWallBackgroundColour = colour;
}

- (UIColor *)storyWallForegroundColour
{
    if (_storyWallForegroundColour != nil) {
        return _storyWallForegroundColour;
    }
    return [UIColor whiteColor];
}

- (void)setStoryWallForegroundColour: (UIColor *)colour
{
    _storyWallForegroundColour = colour;
}

- (UIColor *)storyWallCellDividerColour
{
    if (_storyWallCellDividerColour != nil) {
        return _storyWallCellDividerColour;
    }
    return [UIColor grayColor];
}

- (void)setStoryWallCellDividerColour: (UIColor *)colour
{
    _storyWallCellDividerColour = colour;
}

- (UIColor *)storyWallCellTitleColour
{
    if (_storyWallCellTitleColour != nil) {
        return _storyWallCellTitleColour;
    }
    return [UIColor blackColor];
}

- (void)setStoryWallCellTitleColour: (UIColor *)colour
{
    _storyWallCellTitleColour = colour;
}

- (UIColor *)storyWallCellTextColour
{
    if (_storyWallCellTextColour != nil) {
        return _storyWallCellTextColour;
    }
    return [UIColor darkGrayColor];
}

- (void)setStoryWallCellTextColour: (UIColor *)colour
{
    _storyWallCellTextColour = colour;
}

- (UIColor *)storyWallCellDateColour
{
    if (_storyWallCellDateColour != nil) {
        return _storyWallCellDateColour;
    }
    return [UIColor grayColor];
}

- (void)setStoryWallCellDateColour: (UIColor *)colour
{
    _storyWallCellDateColour = colour;
}

- (UIFont *)storyWallCellTitleFont
{
    if (_storyWallCellTitleFont != nil) {
        return _storyWallCellTitleFont;
    }
    return [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
}

- (void)setStoryWallCellTitleFont: (UIFont *)font
{
    _storyWallCellTitleFont = font;
}

- (UIFont *)storyWallCellTextFont
{
    if (_storyWallCellTextFont != nil) {
        return _storyWallCellTextFont;
    }
    return [UIFont systemFontOfSize:12.0 weight:UIFontWeightThin];
}

- (void)setStoryWallCellTextFont: (UIFont *)font
{
    _storyWallCellTextFont = font;
}

- (UIFont *)storyWallCellDateFont
{
    if (_storyWallCellDateFont != nil) {
        return _storyWallCellDateFont;
    }
    return [UIFont systemFontOfSize:10.0 weight:UIFontWeightThin];
}

- (void)setStoryWallCellDateFont: (UIFont *)font
{
    _storyWallCellDateFont = font;
}

- (int)storyWallCellHeight
{
    if (_storyWallCellHeight != nil) {
        return [_storyWallCellHeight intValue];
    }
    return 120;
}

- (void)setStoryWallCellHeight: (int)size
{
    _storyWallCellHeight = [NSNumber numberWithInt:size];
}

@end
