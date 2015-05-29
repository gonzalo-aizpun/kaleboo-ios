//
//  State.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBState.h"

@implementation KBState

+ (RKObjectMapping *)mapping {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[KBState class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"stateId",
                                                  @"description": @"stateDescription"
                                                  }];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"cities"
                                                                            toKeyPath:@"cities"
                                                                          withMapping:[KBCity mapping]]];
    return mapping;
}

@end
