//
//  City.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBCity.h"

@implementation KBCity

+ (RKObjectMapping *)mapping {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[KBCity class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"cityId",
                                                  @"description": @"cityDescription"
                                                  }];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"neighborhoods"
                                                                            toKeyPath:@"neighborhoods"
                                                                          withMapping:[KBNeighborhood mapping]]];
    return mapping;
}

@end
