//
//  AppDelegate.h
//  udpClient
//
//  Created by User on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import "LeftController.h"
#import "RightController.h"

@class WinampController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DDMenuController *menuController;

@end
