//
//  KBApiAccess.h
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/29/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBApiAccess : NSObject

- (void)getStatesFor:(NSString *)country
             success:(void (^)(NSArray *))success
             failure:(void (^)(NSError *))failure;

@end
