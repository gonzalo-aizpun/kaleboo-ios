//
//  State.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "State.h"

@implementation State

+ (RKObjectMapping *)mapping {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[State class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id": @"stateId",
                                                        @"name": @"name",
                                                        @"url": @"url"}];
    return mapping;
}

@end
