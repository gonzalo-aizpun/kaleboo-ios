//
//  ViewController.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "ViewController.h"

#import "KBApiAccess.h"
#import "KBHome.h"
#import "KBItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KBApiAccess * apiAccess = [[KBApiAccess alloc] init];
    
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
    
    
    
    [apiAccess fetchItemsWithSuccess:^(NSArray * items) {
        for (KBItem * item in items) {
            NSLog(@"%@", item.email);
        }
    } withFailure:^(NSError * e) {
        NSLog(@"%@", e);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
