//
//  WoodooDialog.h
//  develop
//
//  Created by Tamas Dancsi on 04/03/2017.
//  Copyright © 2017 Appwoodoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WoodooDialog : NSObject

@property(nonatomic, readwrite) NSString *title;
@property(nonatomic, readwrite) NSString *name;
@property(nonatomic, readwrite) NSString *bodyText;
@property(nonatomic, readwrite) NSString *bodyImage;
@property(nonatomic, readwrite) NSString *closeButtonTitle;
@property(nonatomic, readwrite) NSString *actionButtonTitle;
@property(nonatomic, readwrite) NSString *actionButtonUrl;

@end
