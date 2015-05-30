//
//  KBPagerViewController.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KBState.h"

@interface KBPagerViewController : UIViewController

@property (nonatomic) KBState * state;
@property (nonatomic) NSNumber * rooms;
@property (nonatomic) NSNumber * minPrice;
@property (nonatomic) NSNumber * maxPrice;

@end
