//
//  WoodooStoryListTableViewCell.h
//  develop
//
//  Created by Tamas Dancsi on 20/12/2016.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WoodooStoryViewOptions.h"

/**
 * A helper class inherited from UITableViewCell
 * that displays a single story list item from Appwoodoo
 */
@interface WoodooStoryListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *title;
@property (weak, nonatomic) IBOutlet UITextView *subtitle;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIView *separator;

- (void)setupColours: (WoodooStoryViewOptions *)viewOptions;

@end
