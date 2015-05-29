//
//  ViewController.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "ViewController.h"

#import "KBApiAccess.h"
#import "KBState.h"
#import "KBFilter.h"
#import "KBItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KBApiAccess * apiAccess = [[KBApiAccess alloc] init];
    
    [self testInitializationWithApi:apiAccess];
        NSLog(@"\n\n\n");
    
    [self testItemsWithApi:apiAccess];
        NSLog(@"\n\n\n");
    
    [apiAccess filterNumericBiggerThanValue:@985000 forKey:@"price"];
    [self testItemsWithApi:apiAccess];
        NSLog(@"\n\n\n");
    
    [apiAccess filterComboWithValue:@"1" forKey:@"id_identity"];
    [self testItemsWithApi:apiAccess];
        NSLog(@"\n\n\n");
}

- (void)testInitializationWithApi:(KBApiAccess *)apiAccess {
    [apiAccess fetchInitializationInformationWithSuccess:^(NSArray * states, NSArray * filters) {
        for (KBState * state in states) {
            NSLog(@"%@ (%@)", state.stateDescription, state.stateId);
            for (KBCity * city in state.cities) {
                NSLog(@"\t\t%@ (%@)", city.cityDescription, city.cityDescription);
                for (KBNeighborhood * barrio in city.neighborhoods) {
                    NSLog(@"\t\t\t\t %@ (%@)", barrio.neighborhoodDescription, barrio.neighborhoodId);
                }
            }
        }
        for (KBFilter * filter in filters) {
            NSLog(@"%@ (%@)", filter.filterId, filter.filterType);
            for (KBFilterValue * value in filter.values) {
                NSLog(@"\t\t%@ (%@)", value.filterValueDescription, value.filterValueId);
            }
        }
    } withFailure:^(NSError * e) {
        NSLog(@"%@", e);
    }];
}

- (void)testItemsWithApi:(KBApiAccess *)apiAccess {
    [apiAccess fetchItemsWithSuccess:^(NSArray * items) {
        int i = 0;
        for (KBItem * item in items) {
            NSLog(@"%d>> %@", i, item.email);
            i ++;
        }
    } withFailure:^(NSError * e) {
        NSLog(@"%@", e);
    }];
}

@end
