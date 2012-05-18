//
//  ControllerManager.m
//  udpClient
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ControllerManager.h"
#import "Request.h"
#import "JSON.h"

#define LAST_CONNECTED_SERVER_KEY @"LAST_CONNECTED_SERVER_KEY"


@interface ControllerManager (PRIVATE)
-(void)saveServer;
-(void)loadServer;
@end

    
    
@implementation ControllerManager

NSString* const SERVER_DISCONNERCT = @"SERVER_DISCONNERCT";
NSString* const SERVER_CONNERCT = @"SERVER_CONNERCT";

@synthesize serverTcp = _serverTcp,
            poolTimer = _poolTimer,
            delegateServers = _delegateServers,
            delegateData = _delegateData,
            server = _server;

static ControllerManager* instance = nil;
+(ControllerManager*) getInstance
{
	if(instance == nil) {
		instance = [[ControllerManager alloc] init];
	}
	return instance;
}

-(id) init 
{
    self = [super init];
    if(self) {
        _poolStatusControl = [[NSMutableSet alloc] init];
    }
    return self;
}

-(void) initConnection:(Server*) server 
{
    self.server = server;
    if(self.serverTcp == nil) {
        self.serverTcp = [[ServerTCP alloc] init];
        self.serverTcp.delegate = self;
    }
    
    //save last connected server
    [self saveServer];

    if([self.serverTcp.asyncSocket isConnected]){
        [self closeConnection];
        needToConnectToHost = YES;
    }
    else{
        [self.serverTcp connect:self.server];
    }
}

-(void)saveServer 
{
    NSData *serverObject = [NSKeyedArchiver archivedDataWithRootObject:self.server];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:serverObject forKey:LAST_CONNECTED_SERVER_KEY];
    [defaults synchronize];
}

-(void)loadServer 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *serverObject = [defaults objectForKey:LAST_CONNECTED_SERVER_KEY];
    self.server = (Server *)[NSKeyedUnarchiver unarchiveObjectWithData:serverObject];
}

-(void) tryToReconnectToLastConnectedServer
{
    [self loadServer];
    if(self.server != nil) {
        [self initConnection:self.server];
    }
}

-(void) closeConnection 
{
    [self.serverTcp disconnect];
}

-(void) sendCommand:(ControlCommands)command control:(int)control 
{
    [self sendCommand:command control:control args:@""];
}

-(void) sendCommand:(ControlCommands)command control:(int)control args:(NSString*)args
{
    Request *req = [[[Request alloc] init] autorelease];
    req.control = control;
    req.command = (int)command;
    req.args = args;
    NSString *data = [req serialize];
    [self.serverTcp sendData:data];
}



#pragma ---------------------
#pragma Pool 

-(void) startPoolPlayStatus:(int)control delegate:(id)delegate
{
    self.delegateData = delegate;
    [_poolStatusControl addObject:[NSNumber numberWithInt:control]];
    
    if(self.poolTimer == nil) {
        self.poolTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(poolInterval) userInfo:nil repeats:YES];
    }
}

-(void) stopPoolPlayStatus:(int)control 
{
    [_poolStatusControl removeObject:[NSNumber numberWithInt:control]];
    if([_poolStatusControl count] == 0) {
        [self.poolTimer invalidate];
        self.poolTimer = nil;
    }
}

-(void) stopPoolDataForAllControls 
{
    [self.poolTimer invalidate];
    self.poolTimer = nil;
}

-(void) poolInterval 
{
    if([self.serverTcp isConnected]) {
        for(id element in _poolStatusControl) {
            [self sendCommand:Status control:[element intValue]];
        }
    }
}



#pragma -----------------------
#pragma ServerTcpProtocol

-(void) serverTcpDidDisconnect 
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SERVER_DISCONNERCT object:nil userInfo:nil];
    if(needToConnectToHost) {
        [self.serverTcp connect:self.server];
        needToConnectToHost = NO;
    }
}

-(void) serverTcpDidConnectToHost:(NSString *)host port:(UInt16)port 
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SERVER_CONNERCT object:nil userInfo:nil];
}

-(void) serverTcpDidReadData:(NSString *)data withTag:(long)tag 
{
    NSDictionary *dic = [data JSONValue];
    ControlStatus *status = [[[ControlStatus alloc] initWithDictionary:dic] autorelease];
    [self.delegateData controllerManagerDidReciveData:status];
}



#pragma -------------
#pragma DiscoveryUDP

-(void) searchServers
{
    [DiscoveryUDP activeDiscoveryUDP].delegate = self;
    [[DiscoveryUDP activeDiscoveryUDP] startSearching];
}

-(void) discoveryUDPServerFound:(Server *)server
{
    [self.delegateServers controllerManagerServerFound:server];
}




-(void) dealloc {
    [_server release];
    [_serverTcp setDelegate:nil];
    [_serverTcp release];
    [_poolStatusControl release];
    [_poolTimer invalidate];
    [_poolTimer release];
    [super dealloc];
}

@end
