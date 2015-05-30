//
//  KBHomeViewController.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBHomeViewController.h"

#import <TTRangeSlider/TTRangeSlider.h>
#import <IQDropDownTextField/IQDropDownTextField.h>

#import "KBApiAccess.h"
#import "KBState.h"
#import "KBFilter.h"

@interface KBHomeViewController ()

@property (weak, nonatomic) IBOutlet IQDropDownTextField *stateLabel;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *roomsLabel;

@property (weak, nonatomic) IBOutlet TTRangeSlider * priceSlider;

@end

@implementation KBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.stateLabel setText:@""];
    [self.roomsLabel setText:@""];
    
    __weak KBHomeViewController * weakSelf = self;
    [[KBApiAccess sharedInstance] fetchInitializationInformationWithSuccess:^(NSArray * states, NSArray * filters) {
        __strong KBHomeViewController * strongSelf = weakSelf;
        
        [strongSelf initializeController];
        
    } withFailure:^(NSError * e) {
        NSLog(@"%@", e);
    }];
}

- (void)initializeController {
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self action:@selector(toolbarDoneClicked:)];
    [buttonDone setTintColor:[UIColor colorWithRed:0.55 green:0.78 blue:0.3 alpha:1.0]];
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    
    self.stateLabel.inputAccessoryView = toolbar;
    self.roomsLabel.inputAccessoryView = toolbar;
    self.stateLabel.isOptionalDropDown = NO;
    self.roomsLabel.isOptionalDropDown = NO;
    
    NSMutableArray * statesNames = [[NSMutableArray alloc] init];
    
    [[[KBApiAccess sharedInstance] locationTree] enumerateObjectsUsingBlock:^(KBState * obj, NSUInteger idx, BOOL *stop) {
        [statesNames addObject:[obj stateDescription]];
    }];
    
    self.stateLabel.itemList = statesNames;
    
    self.roomsLabel.itemList = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    
}

-(void)toolbarDoneClicked:(UIBarButtonItem*)button {
    [self.view endEditing:YES];
}

#pragma mark - User Actions


- (IBAction)searchTapped:(id)sender {
    
    __weak KBHomeViewController * weakSelf = self;
    NSUInteger idx = [[[KBApiAccess sharedInstance] locationTree] indexOfObjectPassingTest:^BOOL(KBState * obj, NSUInteger idx, BOOL *stop) {
        __strong KBHomeViewController * strongSelf = weakSelf;
        return [obj.stateDescription isEqualToString:strongSelf.stateLabel.text];
    }];
    
    KBState * selectedState;
    if (idx != NSNotFound) {
        selectedState = [[[KBApiAccess sharedInstance] locationTree] objectAtIndex:idx];
    }
    NSLog(@"STATE: %@ (%@)", selectedState.stateDescription, selectedState.stateId);
    NSLog(@"ROOMS: %@", self.roomsLabel.text);
    NSLog(@"PRICE MIN: %f", self.priceSlider.selectedMinimum);
    NSLog(@"PRICE MAX: %f", self.priceSlider.selectedMaximum);
    
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
