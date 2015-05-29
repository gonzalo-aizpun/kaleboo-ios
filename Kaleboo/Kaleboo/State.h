//
//  State.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

@interface State : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * stateId;
@property (nonatomic, retain) NSString * url;

+ (RKObjectMapping *)mapping;

@end
