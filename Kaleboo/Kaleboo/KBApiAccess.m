//
//  KBApiAccess.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBApiAccess.h"

#import <RestKit/RestKit.h>

#import "State.h"

@implementation KBApiAccess

static NSString * const API_URL = @"http://api-v2.olx.com";



- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES; //this will show the network activity indicator in the status bar while an HTTP request is being performed.
        
        NSURL *baseURL = [NSURL URLWithString:API_URL];
        
        RKObjectManager * objectManager = [RKObjectManager managerWithBaseURL:baseURL]; //set the object manager's base server URL
        [RKObjectManager setSharedManager:objectManager];
        
        RKResponseDescriptor *stateResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[State mapping]
                                                                                                     method:RKRequestMethodAny
                                                                                                pathPattern:@"/countries/:country/states"
                                                                                                    keyPath:nil
                                                                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
        
        [[RKObjectManager sharedManager] addResponseDescriptor:stateResponseDescriptor];
        
    }
    return self;
}

- (void)getStatesFor:(NSString *)country
             success:(void (^)(NSArray *))success
             failure:(void (^)(NSError *))failure {
    
    NSString * queryPath = [NSString stringWithFormat:@"/countries/%@/states", country];
    [[RKObjectManager sharedManager] getObjectsAtPath:queryPath
                                           parameters:[KBApiAccess queryParameters]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  NSLog(@"Success");
                                                  success([mappingResult array]);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"Failure");
                                                  failure(error);
                                              }];
}

+ (NSDictionary *) queryParameters {
    
    return @{@"platform": @"ios",
             @"version": @"9.9.9",
             @"languageCode": @"en"
             };
}

@end
