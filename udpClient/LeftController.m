//
//  LeftController.m
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LeftController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "WinampController.h"
#import "BsPlayerController.h"

@implementation LeftController

@synthesize tableView = _tableView;

- (id)init 
{
    if ((self = [super init])) {
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch ([indexPath row]) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"Winamp"];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"Bsplayer"];
            break;
    }
    return cell;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section 
{
    return @"Remote Controls";
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // set the root controller
    BaseController *controller = nil;
    switch ([indexPath row]) {
        case 0:
            controller = [[[WinampController alloc] initWithNibName:@"WinampController" bundle:nil] autorelease];
            [controller.view setBackgroundColor:[UIColor blackColor]];
            controller.controlID = 1;
            break;
        case 1:
            controller = [[[BsPlayerController alloc] initWithNibName:@"BsPlayerController" bundle:nil] autorelease];
            [controller.view setBackgroundColor:[UIColor blueColor]];
            controller.controlID = 2;
            break;
        default:
            break;
    }
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    [menuController setRootController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    self.tableView = nil;
}


@end
