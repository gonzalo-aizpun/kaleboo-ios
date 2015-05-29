//
//  KBFilter.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBFilter.h"

@implementation KBFilter

+ (RKObjectMapping *)mapping {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[KBFilter class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"filterId",
                                                  @"type": @"filterType"
                                                  }];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"values"
                                                                            toKeyPath:@"values"
                                                                          withMapping:[KBFilterValue mapping]]];
    return mapping;
}

@end
