//
//  WoodooDialogView.m
//  develop
//
//  Created by Tamas Dancsi on 04/03/2017.
//  Copyright © 2017 Appwoodoo. All rights reserved.
//

#import "WoodooDialogView.h"
#import "WoodooCustomIOSAlertView.h"

@implementation WoodooDialogView

@synthesize dialogTitle;
@synthesize bodyText;
@synthesize bodyImageContainerView;
@synthesize titleTopConstraint;
@synthesize bodyTextTopConstraint;
@synthesize bodyImageTopConstraint;
@synthesize bodyImageContainer;
@synthesize bodyImageHeightConstraint;

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (void)showWithWoodooDialog: (WoodooDialog *)dialog
{
    NSMutableArray *buttonTitles = [[NSMutableArray alloc] init];
    if ([dialog closeButtonTitle] != nil && ![[dialog closeButtonTitle] isEqualToString:@""]) {
        [buttonTitles addObject:[dialog closeButtonTitle]];
    }
    if ([dialog actionButtonTitle] != nil && ![[dialog actionButtonTitle] isEqualToString:@""]) {
        if ([dialog actionButtonUrl] != nil && ![[dialog actionButtonUrl] isEqualToString:@""]) {
            [buttonTitles addObject:[dialog actionButtonTitle]];
        }
    }

    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"WoodooDialogView" bundle:bundle];

    WoodooDialogView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    int maxWidth = [[UIScreen mainScreen] bounds].size.width - 20;
    int maxHeight = [[UIScreen mainScreen] bounds].size.height - 300;
    
    [view setFrame:CGRectMake(3, 3, maxWidth - 6, maxHeight - 6)];
    
    if ([dialog title] != nil && ![[dialog title] isEqualToString:@""]) {
        [[view dialogTitle] setText:[dialog title]];
    } else {
        [[view dialogTitle] setText:nil];
        [[view dialogTitle] setHidden:true];
        [[view dialogTitle] setFrame:CGRectZero];
        [view titleTopConstraint].constant = 0;

        [[NSLayoutConstraint constraintWithItem:[view dialogTitle] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0] setActive:true];
    }
    
    if ([dialog bodyText] != nil && ![[dialog bodyText] isEqualToString:@""]) {
        [[view bodyText] setText:[dialog bodyText]];
    } else {
        [[view bodyText] setText:nil];
        [[view bodyText] setHidden:true];
        [[view bodyText] setFrame:CGRectZero];
        
        [[NSLayoutConstraint constraintWithItem:[view bodyText] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0] setActive:true];

        [view bodyTextTopConstraint].constant = 0;
        if ([[view dialogTitle] isHidden]) {
            [view bodyImageTopConstraint].constant = 3;
        }
    }
    
    if ([dialog bodyImage] != nil && ![[dialog bodyImage] isEqualToString:@""]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *url = [NSURL URLWithString:[dialog bodyImage]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image != nil) {
                    
                    UIImageView *imageView = [[UIImageView alloc] init];
                    imageView.image = image;
                    
                    float ratio = image.size.width / image.size.height;
                    
                    int height = [view bodyImageContainerView].bounds.size.width / ratio;
                    height = MIN([view bodyImageContainerView].bounds.size.height, height);
                    
                    [[view bodyImageContainerView] setFrame:CGRectMake(0, 0, [view bodyImageContainerView].bounds.size.width, height)];
                    [imageView setFrame:CGRectMake(0, 0, [view bodyImageContainerView].bounds.size.width, height)];
                    
                    [view bodyImageHeightConstraint ].constant = height;

                    [imageView setContentMode:UIViewContentModeScaleAspectFill];
                    [imageView setClipsToBounds:true];
                    
                    [[view bodyImageContainerView] addSubview:imageView];
                } else {
                    [view bodyImageHeightConstraint ].constant = 0;
                }

                [self showAlertView:view buttonTitles:buttonTitles actionButtonUrl:[dialog actionButtonUrl]];

            });
        });
    } else {
        [[view bodyImageContainerView] setHidden:true];
        [[view bodyImageContainerView] setFrame:CGRectZero];
        [view bodyImageTopConstraint].constant = 0;
        [view bodyImageHeightConstraint ].constant = 0;

        [self showAlertView:view buttonTitles:buttonTitles actionButtonUrl:[dialog actionButtonUrl]];
    }
 
}

+ (void)showAlertView: (WoodooDialogView *)containerView buttonTitles:(NSArray *)buttonTitles actionButtonUrl: (NSString *)actionButtonUrl
{
    float margins = containerView.titleTopConstraint.constant + containerView.bodyTextTopConstraint.constant + containerView.bodyImageTopConstraint.constant;

    float height = [containerView dialogTitle].frame.size.height + [containerView bodyImageHeightConstraint].constant + [containerView bodyText].frame.size.height + margins;
   
    [containerView setFrame:CGRectMake(0, 0, containerView.bounds.size.width, height)];

    WoodooCustomIOSAlertView *alertView = [[WoodooCustomIOSAlertView alloc] init];
    [alertView setContainerView:containerView];
    [alertView setButtonTitles:buttonTitles];
    [alertView setOnButtonTouchUpInside:^(WoodooCustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 1) {
            NSURL *actionButtonNSUrl = [NSURL URLWithString:actionButtonUrl];
            [[UIApplication sharedApplication] openURL:actionButtonNSUrl];
        }
        [alertView close];
    }];
    [alertView show];
}

@end
