//
//  WoodooStoriesListViewController.m
//  develop
//
//  Created by Tamas Dancsi on 23/09/16.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import "WoodooStoriesListViewController.h"
#import "WoodooStoriesHandler.h"
#import "WoodooStoryViewController.h"
#import "WoodooStoryListTableViewCell.h"
#import "WoodooStoryViewOptions.h"
#import "Woodoo.h"

@interface WoodooStoriesListViewController ()

@property (nonatomic, strong) NSDictionary *storyWall;
@property (nonatomic, strong) NSArray *stories;
@property (nonatomic, strong) WoodooStoryViewOptions *viewOptions;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation WoodooStoriesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = nil;
    self.clearsSelectionOnViewWillAppear = NO;
    [self initRefreshControl];
    [self refreshStories];
    
    self.viewOptions = [Woodoo getViewOptions];
    
    [self.tableView setRowHeight:(CGFloat)[self.viewOptions storyWallCellHeight]];
    [self.tableView setSeparatorColor:[self.viewOptions storyWallCellDividerColour]];
    
    [self.navigationItem.leftBarButtonItem setTintColor:[self.viewOptions storyWallForegroundColour]];
    [self.navigationItem.rightBarButtonItem setTintColor:[self.viewOptions storyWallForegroundColour]];
    [self.activityIndicator setColor:[self.viewOptions storyWallForegroundColour]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view setBackgroundColor:[self.viewOptions storyWallBackgroundColour]];
}

- (IBAction)onDoneTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshStories) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshStories {
    [WoodooStoriesHandler getStoryWallWithSuccess:^(NSDictionary *storyWall) {
        self.title = storyWall[@"settings"][@"title"];
        self.stories = storyWall[@"stories"];
        self.storyWall = storyWall;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        [self.activityView setHidden:YES];
        
    } failure:^(NSError *error) {
        [self.refreshControl endRefreshing];
        [self.activityView setHidden:YES];
        // TODO: Do something with the error
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WoodooStoryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WoodooStoriesCell" forIndexPath:indexPath];
    
    [cell setupColours:_viewOptions];
    
    NSDictionary *story = self.stories[indexPath.row];
    cell.title.text = story[@"title"];
    cell.subtitle.text = story[@"lead"];
    cell.date.text = story[@"date"];
    
    NSURL *url = [NSURL URLWithString:story[@"cover_thumb"]];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    WoodooStoryListTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell) {
                        updateCell.cover.image = image;
                        [updateCell setNeedsLayout];
                        [updateCell layoutIfNeeded];
                    }
                });
            }
        }
    }];
    [task resume];

    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *story = self.stories[indexPath.row];
    WoodooStoryViewController *vc = segue.destinationViewController;
    [vc setStoryWall:self.storyWall];
    [vc setStory:story];
}

@end
