//
//  KBNeighborhood.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

@interface KBNeighborhood : NSObject

@property (nonatomic) NSNumber * neighborhoodId;
@property (nonatomic) NSString * neighborhoodDescription;

+ (RKObjectMapping *)mapping;

@end
