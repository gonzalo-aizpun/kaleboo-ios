//
//  KBPagerViewController.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBPagerViewController.h"

#import "SwipeView.h"

#import "KBApiAccess.h"
#import "KBItem.h"

@interface KBPagerViewController () <SwipeViewDataSource, SwipeViewDelegate>

@property (nonatomic, weak) IBOutlet SwipeView * swipeView;

@property (nonatomic) NSArray * items;

@end

@implementation KBPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[KBApiAccess sharedInstance] resetFilters];
    [[KBApiAccess sharedInstance] filterComboWithValue:[self.state.stateId stringValue] forKey:@"id_state"];
    [[KBApiAccess sharedInstance] filterNumericEqualToValue:self.rooms forKey:@"rooms"];
    [[KBApiAccess sharedInstance] filterNumericBiggerThanValue:self.minPrice forKey:@"price"];
    [[KBApiAccess sharedInstance] filterNumericSmallerThanValue:self.maxPrice forKey:@"price"];
    
    __weak KBPagerViewController * weakSelf = self;
    [[KBApiAccess sharedInstance] fetchItemsWithSuccess:^(NSArray * items) {
        __strong KBPagerViewController * strongSelf = weakSelf;
        strongSelf.items = items;
        [strongSelf.swipeView reloadData];
    } withFailure:^(NSError * e) {
        NSLog(@"%@", e);    //TODO
    }];
    
    self.swipeView.pagingEnabled = YES;
    [self.swipeView setDelegate:self];
    [self.swipeView setDataSource:self];
}

#pragma mark - SwipeViewDataSource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    return [self.items count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    view.backgroundColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    KBItem * item = [self.items objectAtIndex:index];
    label.text = item.itemId;
    
    return view;
    
    
    
    
    
    
    
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
