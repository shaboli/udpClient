//
//  ControllerManager.h
//  udpClient
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerTCP.h"
#import "Server.h"
#import "ControlStatus.h"
#import "DiscoveryUDP.h"

extern NSString* const SERVER_DISCONNERCT;
extern NSString* const SERVER_CONNERCT;

@protocol ControllerManagerServersProtocol <NSObject>
-(void) controllerManagerServerFound:(Server *)server;
@end

@protocol ControllerManagerDataProtocol <NSObject>
-(void) controllerManagerDidReciveData:(ControlStatus*)status;
@end

typedef enum {
    Play = 1,
    VolUp = 2,
    VolDown = 3,
    Next = 4,
    Prev = 5,
    Seek_Left = 6,
    Seek_Right = 7,
    Pause = 8,
    Stop = 9,
    Mute = 10,
    Shuffle = 11,
    Repeate = 12,
    FullScreen = 13,
    TrackLengthJump = 20,
    Status = 40,
} ControlCommands;

@interface ControllerManager : NSObject <ServerTcpProtocol,DiscoveryUDPProtocol> {
    ServerTCP *_serverTcp;
    NSMutableSet *_poolStatusControl;
    NSTimer *_poolTimer;
    id<ControllerManagerServersProtocol> _delegateServers;
    id<ControllerManagerDataProtocol> _delegateData;
    BOOL needToConnectToHost;
    Server *_server;
}

@property(nonatomic,retain) Server *server;
@property(nonatomic,assign) id<ControllerManagerServersProtocol> delegateServers;
@property(nonatomic,assign) id<ControllerManagerDataProtocol> delegateData;
@property(nonatomic,retain) ServerTCP *serverTcp;
@property(nonatomic,retain) NSTimer *poolTimer;

-(void) initConnection:(Server*) server;
-(void) closeConnection;
+(ControllerManager*) getInstance;
-(void) sendCommand:(ControlCommands)command control:(int)control;
-(void) sendCommand:(ControlCommands)command control:(int)control args:(NSString*)args;

-(void) startPoolPlayStatus:(int)control delegate:(id)delegate;
-(void) stopPoolPlayStatus:(int)control;
-(void) stopPoolDataForAllControls;

-(void) searchServers;
-(void) tryToReconnectToLastConnectedServer;

@end
