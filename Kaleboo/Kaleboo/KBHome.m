//
//  KBHome.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBHome.h"

@implementation KBHome

+ (RKObjectMapping *)mapping {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[KBHome class]];
//    [mapping addAttributeMappingsFromDictionary:@{
//                                                  @"code": @"code",
//                                                  @"message": @"message"
//                                                  }];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"states"
                                                                            toKeyPath:@"states"
                                                                          withMapping:[KBState mapping]]];
//    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"neighborhoods"
//                                                                            toKeyPath:@"neighborhoods"
//                                                                          withMapping:[KBNeighborhood mapping]]];
    return mapping;
}

@end
