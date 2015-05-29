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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KBApiAccess * apiAccess = [[KBApiAccess alloc] init];
    
    [apiAccess fetchInitializationInformationWithSuccess:^(NSArray * a) {
        KBHome * s = a[0];
        for (KBState * state in s.states) {
            NSLog(@"%@ (%@)", state.stateDescription, state.stateId);
            for (KBCity * city in state.cities) {
                NSLog(@"\t\t%@ (%@)", city.cityDescription, city.cityDescription);
                for (KBNeighborhood * barrio in city.neighborhoods) {
                    NSLog(@"\t\t\t\t %@ (%@)", barrio.neighborhoodDescription, barrio.neighborhoodId);
                }
            }
        }
        NSLog(@"%@", s);
    } withFailure:^(NSError * e) {
        NSLog(@"%@", e);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
