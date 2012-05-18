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

#import <UIKit/UIKit.h>

#define CPBPressureNone         0.0f
#define CPBPressureLight        0.1f
#define CPBPressureMedium       0.3f
#define CPBPressureHard         0.8f
#define CPBPressureInfinite     2.0f

@interface CPBPressureTouchGestureRecognizer : UIGestureRecognizer <UIAccelerometerDelegate> {
@public
    float pressure;
    float minimumPressureRequired;
    float maximumPressureRequired;
    
@private
    float pressureValues[30];
    uint currentPressureValueIndex;
    uint setNextPressureValue;
}

@property (readonly, assign) float pressure;
@property (readwrite, assign) float minimumPressureRequired;
@property (readwrite, assign) float maximumPressureRequired;

@end