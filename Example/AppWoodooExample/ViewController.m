//
//  ViewController.m
//  AppWoodooExample
//
//  Created by Tamas Dancsi on 16/06/2013.
//  Copyright (c) 2013 AppWoodoo. All rights reserved.
//

#import "ViewController.h"
#import <AppWoodoo/Woodoo.h>

@interface ViewController () {
    NSDictionary *settings;
}

- (void)refreshData;

@end

@implementation ViewController

- (IBAction)onStartButtonTap:(id)sender
{
    NSString *text = [self.APIKeyField text];
    if (!text || [text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You forgot to add the API key" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }

    /**
     * 1. option
     * You can add an observer to a notification named "WoodooArrived"
     * This will be posted everytime, when woodoo downloaded your data
     */

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWoodooArrived:) name:@"WoodooArrived" object:nil];
    [Woodoo takeOff:text];

    /**
     * 2. option
     * Create Woodoo instance and download settings
     * You can set a callback method or you can call it with only the API key
     */

    [Woodoo takeOff:text target:self selector:@selector(woodooCallback:)];
}

/**
 * Woodoo downloaded callback handler
 */

- (void)woodooCallback:(id *)sender
{
    [self refreshData];
}

/**
 * Woodoo arrived notification handler
 */

- (void)onWoodooArrived:(NSNotification *)notification
{
    if (![notification.name isEqualToString:@"WoodooArrived"]) {
        return;
    }

    [self refreshData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WoodooArrived" object:nil];
}

/**
 * Refresh table data with the results
 */

- (void)refreshData
{
    settings = [Woodoo getSettings];
    [self.table reloadData];
}

#pragma - UITableViewDelegate, UITableDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Settings";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    NSInteger index = [indexPath row];
    cell.textLabel.text = [settings allKeys][index];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [settings allValues][index]];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [settings count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
