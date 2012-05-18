//
//  RightController.h
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerManager.h"

@interface RightController : UITableViewController <ControllerManagerServersProtocol, UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *items;
}

@property(nonatomic,retain) NSMutableArray *items;

-(BOOL) isServerInList:(Server*)server;

@end
