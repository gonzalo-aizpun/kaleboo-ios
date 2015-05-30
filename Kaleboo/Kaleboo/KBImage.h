//
//  KBImage.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/30/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

@interface KBImage : NSObject

@property (nonatomic) NSNumber * imageId;
@property (nonatomic) NSString * imageUrl;

+ (RKObjectMapping *)mapping;

@end
