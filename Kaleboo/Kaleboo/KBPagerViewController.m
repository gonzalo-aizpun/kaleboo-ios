//
//  KBPagerViewController.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBPagerViewController.h"

#import <FSImageViewer/FSBasicImage.h>
#import <FSImageViewer/FSBasicImageSource.h>

#import "KBItemDetailView.h"

#import "SwipeView.h"

#import "KBApiAccess.h"
#import "KBItem.h"
#import "KBFilterValue.h"

@interface KBPagerViewController () <SwipeViewDataSource, SwipeViewDelegate>

@property (nonatomic, weak) IBOutlet SwipeView * swipeView;

@property (nonatomic) NSArray * items;

@property (nonatomic) KBItem * selectedItem;

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
    
    self.selectedItem = [self.items objectAtIndex:index];

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
    
    
    NSString * locationString = [NSString stringWithFormat:@"%@, %@", self.selectedItem.neighborhood.filterValueDescription, self.selectedItem.city.filterValueDescription];
    NSString * rentString = [NSString stringWithFormat:@"CO$ %@", self.selectedItem.price];
    NSString * expenseString = [NSString stringWithFormat:@"CO$ %@", self.selectedItem.expenses];
    // TODO Decimal Separator
    // TODO Location Encoding
    
    detailView.locationLabel.text = locationString;
    detailView.rentLabel.text = rentString;
    detailView.surfaceLabel.text = self.selectedItem.surface;
    detailView.roomsLabel.text = self.selectedItem.rooms;
    detailView.furnishedLabel.text = ([self.selectedItem.furnished.filterValueId intValue] == 1)?@"NO":@"SI";
    detailView.propertyTypeLabel.text = self.selectedItem.type.filterValueDescription;
    detailView.expenseLabel.text = expenseString;
    
    return view;
}

- (void)openGallery {
    
    NSMutableArray * photos = [[NSMutableArray alloc] init];
    int i = 1;
    for (KBImage * image in self.selectedItem.images) {
        NSString * positionString = [NSString stringWithFormat:@"%d / %lu", i, (unsigned long)[self.selectedItem.images count]];
        FSBasicImage *aPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:image.imageUrl] name:positionString];
        [photos addObject:aPhoto];
        i ++;
    }
    FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:photos];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 20.0, CGRectMaxXEdge, CGRectMaxYEdge);

    [toolbar setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [toolbar setShadowImage:[UIImage new] forToolbarPosition:UIToolbarPositionAny];
    
    [toolbar setTintColor:[UIColor colorWithRed:0.55 green:0.78 blue:0.3 alpha:1.0]];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self action:@selector(toolbarDoneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonDone, buttonflexible, nil]];
    
    FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    [imageViewController.view addSubview:toolbar];
    
    //    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imageViewController];
    //    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    [self presentViewController:imageViewController animated:YES completion:nil];
}

-(void)toolbarDoneClicked:(UIBarButtonItem*)button {
    [self dismissViewControllerAnimated:YES completion:nil];
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
