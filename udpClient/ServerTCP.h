//
//  ServerTCP.h
//  udpClient
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "Server.h"

@protocol ServerTcpProtocol <NSObject>

-(void) serverTcpDidConnectToHost:(NSString*)host port:(UInt16)port;
-(void) serverTcpDidReadData:(NSString*)data withTag:(long)tag;
-(void) serverTcpDidDisconnect;

@end

@interface ServerTCP : NSObject {
    GCDAsyncSocket *_asyncSocket;
    id<ServerTcpProtocol> _delegate;
    NSString *_serverConnectedIP;
}

@property(nonatomic, copy) NSString *serverConnectedIP;
@property(nonatomic, assign) id<ServerTcpProtocol> delegate;
@property(nonatomic, retain) GCDAsyncSocket *asyncSocket;

-(void) connect:(Server*)server;
-(void) sendData:(NSString*)dataToSend;
-(void) disconnect;
-(BOOL) isConnected;

@end
