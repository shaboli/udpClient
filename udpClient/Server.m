//
//  Server.m
//  udpClient
//
//  Created by User on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Server.h"

@implementation Server

@synthesize ip,
            port;

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.ip = [coder decodeObjectForKey:@"ip"];
        self.port = [[coder decodeObjectForKey:@"port"] intValue];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:ip forKey:@"ip"];
    [coder encodeObject:[NSNumber numberWithInt:port] forKey:@"port"];
}

-(void) dealloc {
    [ip release];
    [super dealloc];
}

@end
