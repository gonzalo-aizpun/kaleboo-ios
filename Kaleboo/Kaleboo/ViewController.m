//
//  ViewController.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "ViewController.h"

#import "KBApiAccess.h"
#import "State.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    KBApiAccess * apiAccess = [[KBApiAccess alloc] init];

    [apiAccess getStatesFor:@"www.olx.com.ar" success:^(NSArray * a) {
        State * s = a[3];
        NSLog(@"%@", s);
    } failure:^(NSError * e) {
        NSLog(@"%@", e);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
