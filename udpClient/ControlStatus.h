//
//  Status.h
//  udpClient
//
//  Created by User on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControlStatus : NSObject {
    NSString *trackName;
    NSString *playListCurrent;
    NSString *playListLenght;
    NSString *playStatus;
    NSString *trackPlayPosition;
    NSString *trackLenght;
    NSString *trackSamplerate;
    NSString *trackBitrate;
    NSString *trackChannels;
    int trackPlayPositionSec;
    int trackLenghtSec;
    int repeate;
    int shuffle;
}

@property(nonatomic,assign) int repeate;
@property(nonatomic,assign) int shuffle;
@property(nonatomic,assign) int trackPlayPositionSec;
@property(nonatomic,assign) int trackLenghtSec;
@property(nonatomic,copy) NSString *trackName;
@property(nonatomic,copy) NSString *playListCurrent;
@property(nonatomic,copy) NSString *playListLenght;
@property(nonatomic,copy) NSString *playStatus;
@property(nonatomic,copy) NSString *trackPlayPosition;
@property(nonatomic,copy) NSString *trackLenght;
@property(nonatomic,copy) NSString *trackSamplerate;
@property(nonatomic,copy) NSString *trackBitrate;
@property(nonatomic,copy) NSString *trackChannels;

-(id) initWithDictionary:(NSDictionary*) dictionary;

@end
