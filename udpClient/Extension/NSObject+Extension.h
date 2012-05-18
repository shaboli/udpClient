//
//  NSObject+Extension.h
//  isracard
//
//  Created by ykm dev on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

-(void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
