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
#import "KBItem.h"

@implementation KBApiAccess

static NSString * const API_URL = @"http://api.kaleboo.com";

#pragma mark - Requests

- (void)fetchInitializationInformationWithSuccess:(void (^)(NSArray *, NSArray *))success withFailure:(void (^)(NSError *))failure {
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"home/index.php"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  NSDictionary * dictionary = [mappingResult dictionary];
                                                  success(dictionary[@"data.states"], dictionary[@"data.filters"]);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  failure(error);
                                              }];
}

- (void)fetchItemsWithSuccess:(void (^)(NSArray *))success withFailure:(void (^)(NSError *))failure {
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"items/index.php"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  success([mappingResult array]);
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
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
//        
//        RKResponseDescriptor * homeRD = [RKResponseDescriptor responseDescriptorWithMapping:[KBHome mapping]
//                                                                                     method:RKRequestMethodAny
//                                                                                pathPattern:nil
//                                                                                    keyPath:@"data"
//                                                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//        [[RKObjectManager sharedManager] addResponseDescriptor:homeRD];

        
        RKResponseDescriptor * locationsRD = [RKResponseDescriptor responseDescriptorWithMapping:[KBState mapping]
                                                                                          method:RKRequestMethodAny
                                                                                     pathPattern:nil
                                                                                         keyPath:@"data.states"
                                                                                     statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
        [[RKObjectManager sharedManager] addResponseDescriptor:locationsRD];
        
        RKResponseDescriptor * filtersRD = [RKResponseDescriptor responseDescriptorWithMapping:[KBFilter mapping]
                                                                                        method:RKRequestMethodAny
                                                                                   pathPattern:nil
                                                                                       keyPath:@"data.filters"
                                                                                   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
        [[RKObjectManager sharedManager] addResponseDescriptor:filtersRD];
        
        RKResponseDescriptor * itemsRD = [RKResponseDescriptor responseDescriptorWithMapping:[KBItem mapping]
                                                                                      method:RKRequestMethodAny
                                                                                 pathPattern:nil
                                                                                     keyPath:@"data.items"
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
        [[RKObjectManager sharedManager] addResponseDescriptor:itemsRD];
        
    }
    return self;
}

@end
