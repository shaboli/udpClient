//
//  Request.m
//  udpClient
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Request.h"
#import "JSON.h"

@implementation Request

@synthesize command = _command,
            control = _control,
            args = _args;

-(NSString*) serialize {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[NSString stringWithFormat:@"%d",self.command] forKey:@"command"];
    [dic setValue:[NSString stringWithFormat:@"%d",self.control] forKey:@"control"];
    [dic setValue:[NSString stringWithFormat:@"%@",self.args] forKey:@"args"];
    
    //NSError *error;
    //NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *json = [dic JSONRepresentation];
    //NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

@end
