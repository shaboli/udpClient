//
//  DiscoveryUDP.h
//  udpClient
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"
#import "Server.h"

@protocol DiscoveryUDPProtocol <NSObject>
-(void) discoveryUDPServerFound:(Server*)server;
@end

@interface DiscoveryUDP : NSObject {
    GCDAsyncUdpSocket *_udpSocket;
    NSMutableArray *_serverListOld;
    NSMutableArray *_serverList;
    BOOL isSearching;
    id<DiscoveryUDPProtocol> _delegate;
}

@property(nonatomic, assign) id<DiscoveryUDPProtocol> delegate;
@property(nonatomic, retain) GCDAsyncUdpSocket *udpSocket;
@property(nonatomic, retain) NSMutableArray *serverList;
@property(nonatomic, retain) NSMutableArray *serverListOld;

+(DiscoveryUDP*) activeDiscoveryUDP;
-(void) initUDP;
-(void) startSearching;

@end
