//
//  BaseController.h
//  udpClient
//
//  Created by User on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseControllerDelegate <NSObject>
-(void) showServers;
-(void) showControllers;
@end

@interface BaseController : UIViewController {

    id<BaseControllerDelegate> delegate;
    int controlID;
}

@property(nonatomic,assign) int controlID;
@property(nonatomic,assign) id<BaseControllerDelegate> delegate;

@end
