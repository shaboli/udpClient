//
//  Request.h
//  udpClient
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject{
    int _command;
    int _control;
    NSString *_args;
}

@property(nonatomic,assign) NSString *args;
@property(nonatomic,assign) int command;
@property(nonatomic,assign) int control;

-(NSString*) serialize;

@end
