//
//  KBState.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

#import "KBCity.h"

@interface KBState : NSObject

@property (nonatomic) NSNumber * stateId;
@property (nonatomic) NSString * stateDescription;
@property (nonatomic) NSArray * cities;

+ (RKObjectMapping *)mapping;

@end
