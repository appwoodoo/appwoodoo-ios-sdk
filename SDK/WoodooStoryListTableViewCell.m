//
//  WoodooStoryListTableViewCell.m
//  develop
//
//  Created by Tamas Dancsi on 20/12/2016.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import "WoodooStoryListTableViewCell.h"

@interface WoodooStoryListTableViewCell ()

@property (nonatomic, strong) WoodooStoryViewOptions *viewOptions;

@end

@implementation WoodooStoryListTableViewCell

- (void)setupColours:(WoodooStoryViewOptions *)viewOptions
{
    self.viewOptions = viewOptions;
    [self setBackgroundColor:[viewOptions storyWallBackgroundColour]];
    
    [self.title setFont:[viewOptions storyWallCellTitleFont]];
    [self.subtitle setFont:[viewOptions storyWallCellTextFont]];
    [self.date setFont:[viewOptions storyWallCellDateFont]];

    [self.title setTextColor:[viewOptions storyWallCellTitleColour]];
    [self.subtitle setTextColor:[viewOptions storyWallCellTextColour]];
    [self.date setTextColor:[viewOptions storyWallCellDateColour]];
    
    [self.separator setBackgroundColor:[viewOptions storyWallCellDividerColour]];

    // Set selected background color
    UIView *backgroundColourView = [[UIView alloc] initWithFrame:self.frame];
    backgroundColourView.backgroundColor = [self darkerColor:[viewOptions storyWallBackgroundColour]];
    self.selectedBackgroundView = backgroundColourView;
}

- (UIColor *)darkerColor: (UIColor *)color {
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MAX(r - 0.05, 0.0)
                               green:MAX(g - 0.05, 0.0)
                                blue:MAX(b - 0.05, 0.0)
                               alpha:a];
    }
    return [UIColor lightGrayColor];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted && self.viewOptions) {
        [self.separator setBackgroundColor:[self.viewOptions storyWallCellDividerColour]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected && self.viewOptions) {
        [self.separator setBackgroundColor:[self.viewOptions storyWallCellDividerColour]];
    }
}

@end
