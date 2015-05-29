//
//  KBApiAccess.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBApiAccess.h"

#import <RestKit/RestKit.h>

#import "KBHome.h"

@implementation KBApiAccess

static NSString * const API_URL = @"http://api.kaleboo.com";

#pragma mark - Requests

- (void)fetchInitializationInformationWithSuccess:(void (^)(KBHome *))success withFailure:(void (^)(NSError *))failure {
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"home.php"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  success([mappingResult array][0]);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  failure(error);
                                              }];
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        RKObjectManager * objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:API_URL]];
        [RKObjectManager setSharedManager:objectManager];
        
        RKResponseDescriptor * homeRD = [RKResponseDescriptor responseDescriptorWithMapping:[KBHome mapping]
                                                                                     method:RKRequestMethodAny
                                                                                pathPattern:nil
                                                                                    keyPath:@"data"
                                                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
        [[RKObjectManager sharedManager] addResponseDescriptor:homeRD];
        
    }
    return self;
}

@end
