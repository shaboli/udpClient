//
//  VolumeControl.m
//  udpClient
//
//  Created by User on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VolumeControl.h"
#import "CPBPressureTouchGestureRecognizer.h"

#define MARKER_WIDTH 68.0

@implementation VolumeControl

@synthesize marker,
            timer,
            delegate, 
            isMute = _isMute,
            imagesPrefix;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

-(void) initControl
{
    self.backgroundColor = [UIColor clearColor];
    [self setClipsToBounds:NO];
    
    UIImageView *back = [[UIImageView alloc] initWithFrame:self.bounds];
    [back setBackgroundColor:[UIColor clearColor]];
    [back setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_vol_back.png", self.imagesPrefix]]];
    [self addSubview:back];
    [back release];
    
    self.marker = [[[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-(MARKER_WIDTH/2), 0, MARKER_WIDTH, 44)] autorelease];
    [self addSubview:self.marker];
    [self setMarkerSelected:NO];
    
    CPBPressureTouchGestureRecognizer *cp = [[CPBPressureTouchGestureRecognizer alloc] initWithTarget:self action:@selector(pressure)];
    cp.maximumPressureRequired = 1.0;
    cp.maximumPressureRequired = 2.0;
    [cp setCancelsTouchesInView:NO];
    [cp setDelaysTouchesEnded:NO];
    [self addGestureRecognizer:cp];
    [cp release];
}

-(void) pressure
{
    NSLog(@"PRESS");
}

-(void) touchesBegan:(NSSet * )touches withEvent:(UIEvent * )event 
{
	if(isAnimating) return;
	
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	if(CGRectContainsPoint(self.marker.frame, point)) {
		isTouch = YES;
        [self setMarkerSelected:YES];
	}
	else {
        isTouch = NO;
	}
    
    startDragPosX = self.marker.frame.origin.x;
}

-(void) touchesMoved:(NSSet * )touches withEvent:(UIEvent * )event 
{
	if(isAnimating) return;
	
	if(isTouch) {
        isDragging = YES;
        
		UITouch *touch = [touches anyObject];
		CGPoint prevPoint = [touch previousLocationInView:self];
		CGPoint point = [touch locationInView:self];
		float delta = point.x - prevPoint.x;
        
		CGPoint center = self.marker.center;
        float xPos = center.x + delta;
        float rightX = self.bounds.size.width - self.marker.bounds.size.width/2 + 2.0;
        float leftX = self.marker.bounds.size.width/2 - 2.0;
        
        //lock movment
        if(isMoveLock && point.x > rightX) {
            return;
        }
        else if(isMoveLock && point.x < leftX) {
            return;
        }
        
        if(xPos<leftX) {
            isMoveLock = YES;
            xPos = leftX;
        }
        else if(xPos > rightX) {
            isMoveLock = YES;
            xPos = rightX;
        }
        else {
            isMoveLock = NO;
        }
        
		center.x = xPos; 
		self.marker.center = center;
        
        if(self.timer == nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
        }
	}
}

-(void) touchesEnded:(NSSet * )touches withEvent:(UIEvent * )event 
{
	if(isAnimating) return;
	
	if(isDragging) {
        float xPos = self.bounds.size.width/2-(MARKER_WIDTH/2);
		[self animateToX:xPos];
	}
    else if(isTouch) {
        [delegate volumeControlMute:1];
    }
    
    [self.timer invalidate];
    self.timer = nil;
	isDragging = NO;
    isTouch = NO;
    isMoveLock = NO;
}

-(void) animateToX:(float)xPos 
{
	isAnimating = YES;
	CGRect rect = self.marker.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.23];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animateToXFinished)];
	rect.origin.x = xPos;
	self.marker.frame = rect;
	[UIView commitAnimations];
}

-(void) animateToXFinished 
{
	isAnimating = NO;
    [self setMarkerSelected:NO];
}

-(void) timerTick
{
    float xPos = self.marker.center.x;
    float distance = self.bounds.size.width/2;
    if(xPos > distance) {
        float upDis = distance - MARKER_WIDTH/2;
        float markerXInRegion = xPos - distance;
        float percent = markerXInRegion * upDis / 100;
        int args = 4 * percent / 100;
        [delegate volumeControlUp:args];
    }
    else if(xPos < self.bounds.size.width/2) {
        float downDis = distance - MARKER_WIDTH/2;
        float markerXInRegion = distance - xPos;
        float percent = (markerXInRegion * downDis / 100);
        int args = 4 * percent / 100;
        [delegate volumeControlDown:args];
    }
}

-(void) setMarkerSelected:(BOOL)selected
{
    if(selected) {
        [self.marker setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_vol_btn_s.png", self.imagesPrefix]]];
    }
    else {
        [self.marker setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_vol_btn.png", self.imagesPrefix]]];
    }
    
    CATransition *trans = [CATransition animation];
    trans.duration = 0.2;
    trans.delegate = self;
    trans.fillMode = kCAFillModeForwards;
    trans.type = kCATransitionFade;
    trans.removedOnCompletion = YES;
    trans.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.marker.layer addAnimation:trans forKey:nil];
}

-(void) setIsMute:(BOOL)isMute
{
    _isMute = isMute;
}

-(void) dealloc
{
    [imagesPrefix release];
    [timer invalidate];
    [timer release];
    [marker release];
    [super dealloc];
}

@end
