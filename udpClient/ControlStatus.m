//
//  Status.m
//  udpClient
//
//  Created by User on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ControlStatus.h"

@implementation ControlStatus

@synthesize trackName,playListCurrent,playStatus,playListLenght,trackLenght,trackBitrate,trackChannels,trackSamplerate,trackPlayPosition,
            trackLenghtSec,trackPlayPositionSec,repeate,shuffle;

-(id) initWithDictionary:(NSDictionary*) dictionary {
	if(self = [super init]) {
		self.trackName = [dictionary objectForKey:@"trackName"];
		self.playListCurrent = [dictionary objectForKey:@"playListCurrent"];
        self.playStatus = [dictionary objectForKey:@"playStatus"];
        self.playListLenght = [dictionary objectForKey:@"playListLenght"];
        self.trackLenghtSec = [[dictionary objectForKey:@"trackLenghtSec"] intValue];
        self.trackLenght = [dictionary objectForKey:@"trackLenght"];
        self.trackBitrate = [dictionary objectForKey:@"trackBitrate"];
        self.trackChannels = [dictionary objectForKey:@"trackChannels"];
        self.trackSamplerate = [dictionary objectForKey:@"trackSamplerate"];
        self.trackPlayPosition = [dictionary objectForKey:@"trackPlayPosition"];
        self.trackPlayPositionSec = [[dictionary objectForKey:@"trackPlayPositionSec"] intValue];
        self.repeate = [[dictionary objectForKey:@"repeat"] intValue];
        self.shuffle = [[dictionary objectForKey:@"shuffle"] intValue];
	}
	return self;
}

-(void) dealloc 
{
    [trackName release];
    [playListCurrent release];
    [playStatus release];
    [playListLenght release];
    [trackLenght release];
    [trackBitrate release];
    [trackChannels release];
    [trackSamplerate release];
    [trackPlayPosition release];
    [super dealloc];
}

@end
