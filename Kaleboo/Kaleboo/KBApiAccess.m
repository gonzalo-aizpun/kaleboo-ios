//
//  KBApiAccess.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBApiAccess.h"

#import <RestKit/RestKit.h>

#import "KBState.h"
#import "KBFilter.h"
#import "KBItem.h"

@interface KBApiAccess ()

@property (nonatomic) NSMutableDictionary * filtersDictionary;

@end

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
                                           parameters:self.filtersDictionary
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self resetFilters];
                                                  success([mappingResult array]);
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  [self resetFilters];
                                                  failure(error);
                                              }];
}

#pragma mark - Filters

- (void)filterComboWithValue:(NSString *)value forKey:(NSString *)key {
    [self.filtersDictionary setObject:value forKey:key];
}

- (void)filterNumericBiggerThanValue:(NSNumber *)value forKey:(NSString *)key {
    NSString * minKey = [NSString stringWithFormat:@"min_%@", key];
    [self.filtersDictionary setObject:value forKey:minKey];
}

- (void)filterNumericSmallerThanValue:(NSNumber *)value forKey:(NSString *)key {
    NSString * maxKey = [NSString stringWithFormat:@"max_%@", key];
    [self.filtersDictionary setObject:value forKey:maxKey];
}

- (void)filterNumericEqualToValue:(NSNumber *)value forKey:(NSString *)key {
    NSString * minKey = [NSString stringWithFormat:@"min_%@", key];
    NSString * maxKey = [NSString stringWithFormat:@"max_%@", key];
    [self.filtersDictionary setObject:value forKey:minKey];
    [self.filtersDictionary setObject:value forKey:maxKey];
}

- (void)resetFilters {
    [self.filtersDictionary removeAllObjects];
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.filtersDictionary = [[NSMutableDictionary alloc] init];
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        RKObjectManager * objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:API_URL]];
        [RKObjectManager setSharedManager:objectManager];
        
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
