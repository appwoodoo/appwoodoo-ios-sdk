//
//  WoodooStoryListTableView.m
//  develop
//
//  Created by Richard Dancsi on 20/12/2016.
//  Copyright © 2016 Appwoodoo. All rights reserved.
//

#import "WoodooStoryListTableView.h"

@implementation WoodooStoryListTableView

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.stories.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    WoodooStoryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WoodooStoriesCell" forIndexPath:indexPath];
//    NSDictionary *story = self.stories[indexPath.row];
//    cell.title.text = story[@"title"];
//    cell.subtitle.text = story[@"lead"];
//    NSURL *url = [NSURL URLWithString:story[@"cover_thumb"]];
//    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (data) {
//            UIImage *image = [UIImage imageWithData:data];
//            if (image) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    WoodooStoryListTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
//                    if (updateCell) {
//                        updateCell.imageView.image = image;
//                        [updateCell setNeedsLayout];
//                        [updateCell layoutIfNeeded];
//                    }
//                });
//            }
//        }
//    }];
//    [task resume];
//    return cell;
//}

@end
