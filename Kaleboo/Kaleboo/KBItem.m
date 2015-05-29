//
//  KBItem.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBItem.h"

@implementation KBItem

+ (RKObjectMapping *)mapping {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[KBItem class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"itemId",
                                                  @"price": @"price",
                                                  @"expenses": @"expenses",
                                                  @"rooms": @"rooms",
                                                  @"surface": @"surface",
                                                  @"email": @"email"
                                                  }];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"state"
                                                                            toKeyPath:@"state"
                                                                          withMapping:[KBFilterValue mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"city"
                                                                            toKeyPath:@"city"
                                                                          withMapping:[KBFilterValue mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"neighborhood"
                                                                            toKeyPath:@"neighborhood"
                                                                          withMapping:[KBFilterValue mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"type"
                                                                            toKeyPath:@"type"
                                                                          withMapping:[KBFilterValue mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"identity"
                                                                            toKeyPath:@"identity"
                                                                          withMapping:[KBFilterValue mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"furnished"
                                                                            toKeyPath:@"furnished"
                                                                          withMapping:[KBFilterValue mapping]]];
    return mapping;
}

@end
