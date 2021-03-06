//
//  KBApiAccess.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBApiAccess.h"

#import <RestKit/RestKit.h>

@interface KBApiAccess ()

@property (nonatomic) NSMutableDictionary * appliedFiltersDictionary;

@end

@implementation KBApiAccess

static NSString * const API_URL = @"http://api.kaleboo.com";

#pragma mark - Requests

- (void)fetchInitializationInformationWithSuccess:(void (^)(NSArray *, NSArray *))success withFailure:(void (^)(NSError *))failure {
    
    __weak KBApiAccess * weakSelf = self;
    [[RKObjectManager sharedManager] getObjectsAtPath:@"home/index.php"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  __strong KBApiAccess * strongSelf = weakSelf;
                                                  NSDictionary * dictionary = [mappingResult dictionary];
                                                  strongSelf.locationTree = dictionary[@"data.states"];
                                                  strongSelf.filters = dictionary[@"data.filters"];
                                                  success(strongSelf.locationTree, strongSelf.filters);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  failure(error);
                                              }];
}

- (void)fetchItemsWithSuccess:(void (^)(NSArray *))success withFailure:(void (^)(NSError *))failure {
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"items/index.php"
                                           parameters:self.appliedFiltersDictionary
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  success([mappingResult array]);
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  failure(error);
                                              }];
}

#pragma mark - Filters

- (void)filterComboWithValue:(NSString *)value forKey:(NSString *)key {
    [self.appliedFiltersDictionary setObject:value forKey:key];
}

- (void)filterNumericBiggerThanValue:(NSNumber *)value forKey:(NSString *)key {
    NSString * minKey = [NSString stringWithFormat:@"min_%@", key];
    [self.appliedFiltersDictionary setObject:value forKey:minKey];
}

- (void)filterNumericSmallerThanValue:(NSNumber *)value forKey:(NSString *)key {
    NSString * maxKey = [NSString stringWithFormat:@"max_%@", key];
    [self.appliedFiltersDictionary setObject:value forKey:maxKey];
}

- (void)filterNumericEqualToValue:(NSNumber *)value forKey:(NSString *)key {
    NSString * minKey = [NSString stringWithFormat:@"min_%@", key];
    NSString * maxKey = [NSString stringWithFormat:@"max_%@", key];
    [self.appliedFiltersDictionary setObject:value forKey:minKey];
    [self.appliedFiltersDictionary setObject:value forKey:maxKey];
}

- (void)resetFilters {
    [self.appliedFiltersDictionary removeAllObjects];
}

#pragma mark - Location Tree

- (KBState *)getStateWithId:(NSNumber *)valueId {
    for (KBState * state in self.locationTree) {
        if ([state.stateId isEqualToNumber:valueId]) {
            return state;
        }
    }
    return nil;
}
- (KBCity *)getCityWithId:(NSNumber *)valueId {
    for (KBState * state in self.locationTree) {
        for (KBCity * city in state.cities) {
            if ([city.cityId isEqualToNumber:valueId]) {
                return city;
            }
        }
    }
    return nil;
}
- (KBNeighborhood *)getNeighborhoodWithId:(NSNumber *)valueId {
    for (KBState * state in self.locationTree) {
        for (KBCity * city in state.cities) {
            for (KBNeighborhood * neighborhood in city.neighborhoods) {
                if ([neighborhood.neighborhoodId isEqualToNumber:valueId]) {
                    return neighborhood;
                }
            }
        }
    }
    return nil;
}

#pragma mark - Initialization

static KBApiAccess * sharedInstance = nil;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t once_token = 0;
    dispatch_once (&once_token, ^{
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] initPrivate];
    });
    return sharedInstance;
}

- (instancetype)init
{
    return [KBApiAccess sharedInstance];
}

- (instancetype)initPrivate {

    self = [super init];
    if (self) {
        
        self.appliedFiltersDictionary = [[NSMutableDictionary alloc] init];
        
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
