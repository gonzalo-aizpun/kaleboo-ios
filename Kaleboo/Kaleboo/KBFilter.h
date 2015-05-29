//
//  KBFilter.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

#import "KBFilterValue.h"

@interface KBFilter : NSObject

@property (nonatomic) NSString * filterId;
@property (nonatomic) NSString * filterType;
@property (nonatomic) NSArray * values;

+ (RKObjectMapping *)mapping;

@end
