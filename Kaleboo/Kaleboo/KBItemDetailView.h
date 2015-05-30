//
//  KBItemDetailView.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/30/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KBPagerViewController.h"

@interface KBItemDetailView : UIView

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentLabel;

@property (weak, nonatomic) IBOutlet UILabel *surfaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomsLabel;
@property (weak, nonatomic) IBOutlet UILabel *furnishedLabel;

@property (weak, nonatomic) IBOutlet UILabel *propertyTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *expenseLabel;

@property (nonatomic) KBPagerViewController * delegate;

@end
