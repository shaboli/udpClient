//
//  NSObject+Extension.m
//  isracard
//
//  Created by ykm dev on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    block = [[block copy] autorelease];
    [self performSelector:@selector(fireBlockAfterDelay:) 
               withObject:block 
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

@end
