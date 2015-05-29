//
//  Neighborhood.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBNeighborhood.h"

@implementation KBNeighborhood

+ (RKObjectMapping *)mapping {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[KBNeighborhood class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"neighborhoodId",
                                                  @"description": @"neighborhoodDescription"
                                                  }];
    return mapping;
}

@end
