//
//  WoodooStoryViewController.m
//  develop
//
//  Created by Tamas Dancsi on 23/09/16.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import "WoodooStoryViewController.h"
#import "Woodoo.h"

@interface WoodooStoryViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) WoodooStoryViewOptions *viewOptions;

@end

@implementation WoodooStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.story) {
        return;
    }

    self.title = self.storyWall[@"settings"][@"title"];
    self.viewOptions = [Woodoo getViewOptions];
    
    [self.view setBackgroundColor:[self.viewOptions storyWallBackgroundColour]];
    [self.webView setBackgroundColor:[self.viewOptions storyWallBackgroundColour]];
    
    [self.navigationItem.leftBarButtonItem setTintColor:[self.viewOptions storyWallForegroundColour]];
    [self.navigationItem.rightBarButtonItem setTintColor:[self.viewOptions storyWallForegroundColour]];
    [self.activityIndicator setColor:[self.viewOptions storyWallForegroundColour]];

    NSURL *url = [NSURL URLWithString:self.story[@"url"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    [self.webView loadRequest:request];
}

# pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityView setHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityView setHidden:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.activityView setHidden:YES];
}

@end
