//
//  ServerTCP.m
//  udpClient
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerTCP.h"

@implementation ServerTCP

@synthesize asyncSocket = _asyncSocket,
            delegate = _delegate,
            serverConnectedIP = _serverConnectedIP;

-(id) init {
    self = [super init];
    if(self) {
        
    }
    return self;
}

-(void) connect:(Server*)server {   
    if(![self.asyncSocket isConnected]) {
        NSError *error;
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        self.asyncSocket = [[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue] autorelease];
        if (![self.asyncSocket connectToHost:server.ip onPort:server.port error:&error])
        {
            NSLog(@"TCP connectToHost: %@", error);
        }
    }
}

-(BOOL) isConnected
{
    return [self.asyncSocket isConnected];
}

-(void) disconnect {
    [self.asyncSocket disconnect];
    self.asyncSocket = nil;
}

-(void) sendData:(NSString*)dataToSend {
    if([self.asyncSocket isConnected]) {
        NSData* aData;
        NSString *pack = [NSString stringWithFormat:@"%@|", dataToSend];
        aData = [pack dataUsingEncoding:NSUTF8StringEncoding];
        [self.asyncSocket writeData:aData withTimeout:-1 tag:1];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"didConnectToHost:%p", sock);
    [self.delegate serverTcpDidConnectToHost:host port:port];
    self.serverConnectedIP = host;
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock
{
	NSLog(@"socketDidSecure:%p", sock);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	//NSLog(@"socket:%p didWriteDataWithTag:%ld", sock, tag);
    
    [self.asyncSocket readDataWithTimeout:5000 tag:tag];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	//NSLog(@"socket:%p didReadData:withTag:%ld", sock, tag);
	
    NSString *httpResponse = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	//NSLog(@"HTTP Response:\n%@", httpResponse);
    
    [self.delegate serverTcpDidReadData:httpResponse withTag:tag];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"socketDidDisconnect:%p withError: %@", sock, err);
    
    [self.asyncSocket setDelegate:nil];
    self.asyncSocket = nil;
    
    [self.delegate serverTcpDidDisconnect];
    self.serverConnectedIP = nil;
}

-(void) dealloc 
{
    _delegate = nil;
    [_serverConnectedIP release];
    [_asyncSocket disconnect];
    [_asyncSocket release];
    [super dealloc];
}


@end
