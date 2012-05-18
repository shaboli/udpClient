//
//  UIButtonLong.h
//  udpClient
//
//  Created by User on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIButtonLong : UIButton {
    NSTimer *timer;
    BOOL isInterval;
}

@property(nonatomic, retain) NSTimer *timer;

-(void) timeInterval;

@end
