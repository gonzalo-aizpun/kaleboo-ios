//
//  KBFilterValue.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBFilterValue.h"

@implementation KBFilterValue

+ (RKObjectMapping *)mapping {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[KBFilterValue class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"filterValueId",
                                                  @"description": @"filterValueDescription"
                                                  }];
    return mapping;
}

@end
