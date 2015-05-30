//
//  KBPagerViewController.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBPagerViewController.h"

#import "KBItemDetailView.h"

#import "SwipeView.h"

#import "KBApiAccess.h"
#import "KBItem.h"
#import "KBFilterValue.h"

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
    
    KBItemDetailView * detailView;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        
        UINib * myNib = [UINib nibWithNibName:@"ItemDetail" bundle:nil];
        detailView = (KBItemDetailView *)[myNib instantiateWithOwner:self options:nil][0];
        [detailView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [detailView setDelegate:self];
        view = detailView;
    }
    else
    {
        detailView = (KBItemDetailView *)view;
    }
    
    KBItem * item = [self.items objectAtIndex:index];
    
    NSString * locationString = [NSString stringWithFormat:@"%@, %@", item.neighborhood.filterValueDescription, item.city.filterValueDescription];
    NSString * rentString = [NSString stringWithFormat:@"CO$ %@", item.price];
    NSString * expenseString = [NSString stringWithFormat:@"CO$ %@", item.expenses];
    // TODO Decimal Separator
    
    detailView.locationLabel.text = locationString;
    detailView.rentLabel.text = rentString;
    detailView.surfaceLabel.text = item.surface;
    detailView.roomsLabel.text = item.rooms;
    detailView.furnishedLabel.text = ([item.furnished.filterValueId intValue] == 1)?@"NO":@"SI";
    detailView.propertyTypeLabel.text = item.type.filterValueDescription;
    detailView.expenseLabel.text = expenseString;
    
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
