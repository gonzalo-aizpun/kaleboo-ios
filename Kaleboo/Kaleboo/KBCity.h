//
//  KBCity.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

#import "KBNeighborhood.h"

@interface KBCity : NSObject

@property (nonatomic) NSNumber * cityId;
@property (nonatomic) NSString * cityDescription;
@property (nonatomic) NSArray * neighborhoods;

+ (RKObjectMapping *)mapping;

@end
