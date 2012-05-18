//
//  UIDevice-Extension.m
//  isracard
//
//  Created by ykm dev on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIDevice-Extension.h"

@implementation UIDevice (Extension)

-(NSString*) uniqueIdentifierNetwizeFix {
    NSString *uniqueIdentifier = [self uniqueIdentifier];
    #if TARGET_IPHONE_SIMULATOR
    uniqueIdentifier = [uniqueIdentifier stringByReplacingOccurrencesOfString:@"-" withString:@""];
    #endif
    return uniqueIdentifier;
}

@end
