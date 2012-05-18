//
//  RightController.m
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RightController.h"
#import "ControllerManager.h"
#import "DDMenuController.h"
#import "AppDelegate.h"

@implementation RightController

@synthesize items;

- (id)init {
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(controllerManagerDidConnectToHost) 
                                                     name:SERVER_CONNERCT
                                                   object:nil];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = (id<UITableViewDelegate>)self;
    self.tableView.dataSource = (id<UITableViewDataSource>)self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.items = [[[NSMutableArray alloc] init] autorelease];
}

-(void) viewDidAppear:(BOOL)animated 
{
    
    [self performSelector:@selector(search) withObject:nil afterDelay:1.0];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.items removeAllObjects];
    [self.tableView reloadData];
}

-(void) search 
{
    [ControllerManager getInstance].delegateServers = self;
    [[ControllerManager getInstance] searchServers];
}



#pragma ------------
#pragma ControllerManagerServersProtocol

-(void) controllerManagerServerFound:(Server *)server 
{
    if([self isServerInList:server]) {
        return;
    }
    
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.items count] inSection:0]];
    [self.items addObject:server];
    [[self tableView] insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
}

-(BOOL) isServerInList:(Server*)server 
{
    for (Server* item in self.items) {
        if([server.ip isEqualToString:item.ip]){
            return YES;
        }
    }
    return NO;
}

-(void) startConnectToServer:(Server*)server 
{
    [[ControllerManager getInstance] initConnection:server];
}



#pragma ------------
#pragma mark - ControllerManagerNotification

-(void) controllerManagerDidConnectToHost 
{
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    [menuController showRootController:YES];
}


#pragma ------------
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [self.items count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    Server *server = (Server*)[self.items objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", server.ip];
    
    return cell;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section 
{
    return @"Local Servers";
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // lets just push another feed view 
    /*UINavigationController *menuController = (UINavigationController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
     FeedController *controller = [[FeedController alloc] init];
     [menuController pushViewController:controller animated:YES];
     [tableView deselectRowAtIndexPath:indexPath animated:YES];*/
    
    Server *server = (Server*)[self.items objectAtIndex:[indexPath row]];
    [self performSelector:@selector(startConnectToServer:) withObject:server afterDelay:1.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
{
    return YES;
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
}

-(void) dealloc
{
    [items release];
    [super dealloc];
}

@end