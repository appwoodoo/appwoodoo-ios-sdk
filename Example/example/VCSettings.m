//
//  VCSettings.m
//  example
//
//  Created by Tamas Dancsi on 19/03/15.
//  Copyright (c) 2015 Appwoodoo. All rights reserved.
//

#import "VCSettings.h"
#import "AppDelegate.h"
#import <Appwoodoo/Woodoo.h>

@interface VCSettings ()

@property (strong, nonatomic) NSDictionary *settings;
@property (weak, nonatomic) IBOutlet UIView *activityView;

@end

@implementation VCSettings

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWoodooArrived:) name:@"WoodooArrived" object:nil];
    [self launchWoodoo];
}

/**
 * Example method to retrieve settings from appwoodoo
 * There are two options, feel free to uncomment/comment the one you'd like to use
 */

- (void)launchWoodoo {
    [self.activityView setHidden:NO];
    
    /**
     * 1. option
     * You can add an observer to a notification named "WoodooArrived"
     * This will be posted everytime, when Appwoodoo downloaded your settings
     */
    //[Woodoo takeOff:APPKey];

    /**
     * 2. option
     * You can call takeOff with a callback method, that will be called when Appwoodoo downloaded your settings
     */
    [Woodoo takeOff:APPKey target:self selector:@selector(woodooCallback:)];
}

- (IBAction)onRefreshTap:(id)sender {
    self.settings = [[NSDictionary alloc] init];
    [self.tableView reloadData];

    [self launchWoodoo];
}

/**
 * Appwoodoo downloaded your settings - callback handler
 */

- (void)woodooCallback:(id *)sender {
    [self refreshData];
}

/**
 * Appwoodoo downloaded your settings - notification handler
 */

- (void)onWoodooArrived:(NSNotification *)notification {
    [self refreshData];
}

/**
 * Refresh table and show your settings
 */

- (void)refreshData {
    [self.activityView setHidden:YES];

    self.settings = [Woodoo getSettings]; // This is how you can retrieve your settings once they are downloaded
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellSetting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSInteger index = [indexPath row];
    cell.textLabel.text = [self.settings allKeys][index];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.settings allValues][index]];
    
    return cell;
}

@end
