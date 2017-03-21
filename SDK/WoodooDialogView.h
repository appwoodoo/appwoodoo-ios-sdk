//
//  WoodooDialogView.h
//  develop
//
//  Created by Tamas Dancsi on 04/03/2017.
//  Copyright © 2017 Appwoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WoodooDialog.h"

@interface WoodooDialogView : UIView

@property (weak, nonatomic) IBOutlet UILabel *dialogTitle;
@property (weak, nonatomic) IBOutlet UITextView *bodyText;
@property (weak, nonatomic) IBOutlet UIView *bodyImageContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bodyTextTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bodyImageTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *bodyImageContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bodyImageHeightConstraint;

+ (void)showWithWoodooDialog: (WoodooDialog *)dialog;

@end
