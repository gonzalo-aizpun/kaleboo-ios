//
//  KBHome.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

#import "KBState.h"
#import "KBFilter.h"

@interface KBHome : NSObject

@property (nonatomic) NSArray * states;
@property (nonatomic) NSArray * filters;

+ (RKObjectMapping *)mapping;

@end
