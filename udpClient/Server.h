//
//  Server.h
//  udpClient
//
//  Created by User on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject <NSCoding> {
    NSString *ip;
    uint16_t port;
}

@property(nonatomic,copy) NSString *ip;
@property(nonatomic,assign) uint16_t port;

@end
