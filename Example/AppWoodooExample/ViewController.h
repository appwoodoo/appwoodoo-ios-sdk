//
//  ViewController.h
//  AppWoodooExample
//
//  Created by Tamas Dancsi on 16/06/2013.
//  Copyright (c) 2013 AppWoodoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *APIKeyField;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
