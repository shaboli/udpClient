//
//  CPBPressureTouchGestureRecognizer.h
//  PressureSensitiveButton
//
//  Created by Anthony Picciano on 3/21/11.
//  Copyright 2011 Anthony Picciano. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions
//  are met:
//  1. Redistributions of source code must retain the above copyright
//     notice, this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright
//     notice, this list of conditions and the following disclaimer in the
//     documentation and/or other materials provided with the distribution.
//  
//  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
//  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
//  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
//  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <UIKit/UIGestureRecognizerSubclass.h>
#import "CPBPressureTouchGestureRecognizer.h"

#define kUpdateFrequency            60.0f
#define KNumberOfPressureSamples    3

@interface CPBPressureTouchGestureRecognizer (private)
- (void)setup;
@end

@implementation CPBPressureTouchGestureRecognizer
@synthesize pressure, minimumPressureRequired, maximumPressureRequired;

- (id)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self != nil) {
        [self setup]; 
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    minimumPressureRequired = CPBPressureNone;
    maximumPressureRequired = CPBPressureInfinite;
    pressure = CPBPressureNone;
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0f / kUpdateFrequency];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
}

#pragma -
#pragma UIAccelerometerDelegate methods

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    int sz = (sizeof pressureValues) / (sizeof pressureValues[0]);
    
    // set current pressure value
    pressureValues[currentPressureValueIndex%sz] = acceleration.z;
    
    if (setNextPressureValue > 0) {
        
        // calculate average pressure
        float total = 0.0f;
        for (int loop=0; loop<sz; loop++) total += pressureValues[loop]; 
        float average = total / sz;
        
        // start with most recent past pressure sample
        if (setNextPressureValue == KNumberOfPressureSamples) {
            float mostRecent = pressureValues[(currentPressureValueIndex-1)%sz];
            pressure = fabsf(average - mostRecent);
        }
        
        // caluculate pressure as difference between average and current acceleration
        float diff = fabsf(average - acceleration.z);
        if (pressure < diff) pressure = diff;
        setNextPressureValue--;
        
        if (setNextPressureValue == 0) {
            if (pressure >= minimumPressureRequired && pressure <= maximumPressureRequired)
                self.state = UIGestureRecognizerStateRecognized;
            else
                self.state = UIGestureRecognizerStateFailed;
        }
    }
    
    currentPressureValueIndex++;
}

#pragma -
#pragma UIGestureRecognizer subclass methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    setNextPressureValue = KNumberOfPressureSamples;
    self.state = UIGestureRecognizerStatePossible;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateFailed;
}

- (void)reset {
    pressure = CPBPressureNone;
    setNextPressureValue = 0;
    currentPressureValueIndex = 0;
}

@end
