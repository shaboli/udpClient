//
//  DiscoveryUDP.m
//  udpClient
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DiscoveryUDP.h"

#define SERVER_BROADCAST_PORT 18500

@implementation DiscoveryUDP

@synthesize udpSocket = _udpSocket,
            serverList = _serverList,
            delegate = _delegate,
            serverListOld = _serverListOld;

static DiscoveryUDP* activeDiscoveryUDP = nil;
+(DiscoveryUDP*) activeDiscoveryUDP
{
	if(activeDiscoveryUDP == nil)
	{
		activeDiscoveryUDP = [[DiscoveryUDP alloc] init];
	}
	return activeDiscoveryUDP;
}

-(id) init 
{
    self = [super init];
    if(self) {
        [self initUDP];
    }
    return self;
}

-(void) initUDP 
{
    NSError *error = nil;
    if(self.udpSocket == nil) {
        self.udpSocket = [[[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()] autorelease];
        [self.udpSocket enableBroadcast:YES error:nil];	
        
        if (![self.udpSocket bindToPort:SERVER_BROADCAST_PORT error:&error])
        {
            NSLog(@"UDP bindToPort: %@", error);
        }
    }
    
    self.serverList = [[[NSMutableArray alloc] init] autorelease];
    self.serverListOld = [[[NSMutableArray alloc] init] autorelease];
}

-(void) startSearching 
{
    [self.serverList removeAllObjects];
    NSError *error = nil;
    [self.udpSocket sendData:[@"are you lior?" dataUsingEncoding:NSASCIIStringEncoding] toHost:@"255.255.255.255" port:SERVER_BROADCAST_PORT withTimeout:20 tag:0];
    if (![self.udpSocket beginReceiving:&error])
    {
        NSLog(@"UDP beginReceiving: %@", error);
    }
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag 
{
    NSLog(@"didSendDataWithTag");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error 
{
    NSLog(@"didNotSendDataWithTag");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
      withFilterContext:(id)filterContext
{
    NSString *host = nil;
    uint16_t port = 0;
    [GCDAsyncUdpSocket getHost:&host port:&port fromAddress:address];
            
	NSString *msg = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	if ([msg hasPrefix:@"ACK"])
	{
        NSArray *array = [msg componentsSeparatedByString:@" "];
        if([array count] == 3) {
            Server *newServer = [[[Server alloc] init] autorelease];
            newServer.ip = [array objectAtIndex:1];
            newServer.port = (uint16_t)[[array objectAtIndex:2] integerValue];
            [self.serverList addObject:newServer];
            [self.delegate discoveryUDPServerFound:newServer];
            NSLog(@"%@", msg);
        }
	}
}

-(void) dealloc
{
    _delegate = nil;
    [_serverList release];
    [_serverListOld release];
    [_udpSocket release];
    [super dealloc];
}


@end
