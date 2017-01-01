//
//  WoodooStoryViewController.h
//  develop
//
//  Created by Tamas Dancsi on 23/09/16.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * A view controller that handles one woodoo story.
 */
@interface WoodooStoryViewController : UIViewController

/**
 * The passed story object, this needs to be passed on intialization time
 */
@property (nonatomic, strong) NSDictionary *storyWall;
@property (nonatomic, strong) NSDictionary *story;

@end
