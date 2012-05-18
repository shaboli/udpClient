//
//  UIButtonLong.m
//  udpClient
//
//  Created by User on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIButtonLong.h"

@implementation UIButtonLong

@synthesize timer;

-(id) initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if(self) {
        [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchCancel];
        [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchCancel];
        [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
        
        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}

-(void) touchDown 
{
    [self timeInterval];
    isInterval = NO;
    if(self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timeInterval) userInfo:nil repeats:YES];
    }
}

-(void) touchUp 
{
    if(!isInterval) {
        if(self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
    } 
    isInterval = NO;
}

-(void) timeInterval
{
    NSLog(@"TIME");
    isInterval = YES;
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end
