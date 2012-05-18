//
//  VolumeControl.h
//  udpClient
//
//  Created by User on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@protocol VolumeControlDelegate <NSObject>
-(void) volumeControlMute:(int)args;
-(void) volumeControlUp:(int)args;
-(void) volumeControlDown:(int)args;
@end

@interface VolumeControl : UIView <UIAccelerometerDelegate> {
    UIImageView *marker;
    BOOL _isMute;
    
    BOOL isAnimating;
    BOOL isDragging;
    BOOL isTouch;
    BOOL isMoveLock;
    float startDragPosX;
    NSTimer *timer;
    id<VolumeControlDelegate> delegate;
    
    NSString *imagesPrefix;
}

@property(nonatomic,assign) BOOL isMute;
@property(nonatomic,assign) id<VolumeControlDelegate> delegate;
@property(nonatomic,retain) NSTimer *timer;
@property(nonatomic,retain) UIImageView *marker;
@property(nonatomic,retain) NSString *imagesPrefix;

-(void) initControl;
-(void) animateToX:(float)xPos;
-(void) setMarkerSelected:(BOOL)selected;

@end
