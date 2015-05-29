//
//  KBHomeViewController.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBHomeViewController.h"

#import <TTRangeSlider/TTRangeSlider.h>
#import "UIViewController+KNSemiModal.h"

@interface KBHomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel * stateLabel;
@property (weak, nonatomic) IBOutlet UILabel * roomsLabel;
@property (weak, nonatomic) IBOutlet TTRangeSlider * priceSlider;

@end

@implementation KBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - User Actions

- (IBAction)changeStateTapped:(id)sender {
    UIImageView * imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeicon"]];
    [self presentSemiView:imagev];
}

- (IBAction)changeRoomsTapped:(id)sender {
    UIImageView * imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeicon"]];
    [self presentSemiView:imagev];
}

- (IBAction)searchTapped:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
