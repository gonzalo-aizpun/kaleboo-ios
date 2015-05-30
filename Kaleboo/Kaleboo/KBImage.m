//
//  KBImage.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/30/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBImage.h"

@implementation KBImage

+ (RKObjectMapping *)mapping {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[KBImage class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"imageId",
                                                  @"url": @"imageUrl"
                                                  }];
    return mapping;
}

@end
