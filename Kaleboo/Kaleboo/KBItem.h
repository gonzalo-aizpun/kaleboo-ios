//
//  KBItem.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

#import "KBFilterValue.h"

@interface KBItem : NSObject

@property (nonatomic) NSString * itemId;
@property (nonatomic) NSString * price;
@property (nonatomic) NSString * expenses;
@property (nonatomic) NSString * rooms;
@property (nonatomic) NSString * surface;
@property (nonatomic) NSString * email;

@property (nonatomic) KBFilterValue * state;
@property (nonatomic) KBFilterValue * city;
@property (nonatomic) KBFilterValue * neighborhood;

@property (nonatomic) KBFilterValue * type;
@property (nonatomic) KBFilterValue * identity;
@property (nonatomic) KBFilterValue * furnished;

+ (RKObjectMapping *)mapping;

@end
