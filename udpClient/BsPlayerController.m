//
//  BsPlayerController.m
//  udpClient
//
//  Created by User on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BsPlayerController.h"

#import "UINavigationBar+UINavigationBarCustom.h"
#import "UICustomBarButtonItem.h"
#import "Request.h"
#import "NSObject+SBJSON.h"
#import "AutoScrollLabel.h"
#import "UIButtonLong.h"

@implementation BsPlayerController

@synthesize lblPlayLength,
            lblPlayCurrentPotition,
            volumeControl,
            lblTrackName,
            lblTrackPosition,
            trackSlider,
            btnPlay,btnShuffle,btnRepeate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.controlID = 2;
    self.volumeControl.delegate = self;
    self.volumeControl.imagesPrefix = @"bs";
    [self.volumeControl initControl];
    [self.btnPlay setImage:[UIImage imageNamed:@"pause_btn_s.png"] forState:UIControlStateHighlighted | UIControlStateSelected];
    
    //UISlider
    UIImage *minImage = [UIImage imageNamed:@"scroll_back_max.png"];
    UIImage *maxImage = [UIImage imageNamed:@"scroll_back.png"];
    UIImage *thumbImage = [UIImage imageNamed:@"scroll_thumb.png"];
    minImage = [minImage stretchableImageWithLeftCapWidth:25.0 topCapHeight:7.0];
    maxImage = [maxImage stretchableImageWithLeftCapWidth:25.0 topCapHeight:7.0];
    [self.trackSlider setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [self.trackSlider setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [self.trackSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    [self.trackSlider setMinimumValue:0.0];
    [self.trackSlider setMaximumValue:0.0];
    [self.trackSlider setValue:0.0];
    
    [self.trackSlider addTarget:self action:@selector(trackSliderBeginEdit) forControlEvents:UIControlEventTouchDown];
    [self.trackSlider addTarget:self action:@selector(trackSliderEndEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.trackSlider addTarget:self action:@selector(trackSliderEndEdit) forControlEvents:UIControlEventTouchUpOutside];
    
    [[ControllerManager getInstance] tryToReconnectToLastConnectedServer];
}

-(void) initNavigationStyle
{
    [self.navigationController.navigationBar initWithCustomStyle:self withImage:@"nav2_back.png" title:@"BsPlayer Control"];
    UICustomBarButtonItem *leftButton = [[[UICustomBarButtonItem alloc] initWithCustomStyle:[UIImage imageNamed:@"nav_controls_btn.png"]] autorelease];
    [leftButton.button addTarget:self action:@selector(showLeftController:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UICustomBarButtonItem *rightButton = [[[UICustomBarButtonItem alloc] initWithCustomStyle:[UIImage imageNamed:@"nav_server_btn.png"]] autorelease];
    [rightButton.button addTarget:self action:@selector(showRightController:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightButton;
}


-(void) showRightController:(id)sender 
{
    [delegate showServers];
}

-(void) showLeftController:(id)sender 
{
    [delegate showControllers];
}


-(void)trackSliderBeginEdit
{
    isSliderTouched = YES;
}

-(void)trackSliderEndEdit
{
    [[ControllerManager getInstance] sendCommand:self.trackSlider.tag control:controlID args:[NSString stringWithFormat:@"%d",(int)[self.trackSlider value]]];
    [self performSelector:@selector(trackSliderEndEditTimeout) withObject:nil afterDelay:0.5];
}

-(void)trackSliderEndEditTimeout
{
    isSliderTouched = NO;
}

-(IBAction)sliderValueChanged:(UISlider *)sender 
{  
    //NSLog(@"%@",[NSString stringWithFormat:@" %.1f", [sender value]]);
} 

-(IBAction)controlClick:(id)sender 
{
    UIButton *btn = (UIButton*)sender;
    [[ControllerManager getInstance] sendCommand:btn.tag control:controlID];
}

-(IBAction)playClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [btn setSelected:!btn.selected];
    
    if(btn.isSelected) {
        [[ControllerManager getInstance] sendCommand:Play control:controlID];
    }
    else {
        [[ControllerManager getInstance] sendCommand:Pause control:controlID];
    }
}

-(IBAction)shuffleClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [btn setSelected:!btn.selected];
    
    [[ControllerManager getInstance] sendCommand:btn.tag control:controlID args:btn.isSelected ? @"1" : @"0"];
}

-(IBAction)repeateClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [btn setSelected:!btn.selected];
    
    [[ControllerManager getInstance] sendCommand:btn.tag control:controlID args:btn.isSelected ? @"1" : @"0"];
}

-(IBAction)fullClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [btn setSelected:!btn.selected];
    
    [[ControllerManager getInstance] sendCommand:btn.tag control:controlID args:btn.isSelected ? @"1" : @"0"];
}

#pragma ----------------
#pragma ControllerManager

-(void) controllerManagerDidReciveData:(ControlStatus *)status
{
    self.lblPlayCurrentPotition.text = status.trackPlayPosition;
    self.lblPlayLength.text = status.trackLenght;
    self.lblTrackName.text = status.trackName;
    self.lblTrackPosition.text = [NSString stringWithFormat:@"track: %@ / %@", status.playListCurrent, status.playListLenght];
    
    [self.trackSlider setMaximumValue:status.trackLenghtSec];
    if(!isSliderTouched) {
        [self.trackSlider setValue:status.trackPlayPositionSec];
    }
    
    
    playButtonUpdateInterval ++;
    if(playButtonUpdateInterval > 1) {
        //repeate
        if(status.repeate == 1) {
            [self.btnRepeate setSelected:YES];
        }
        else {
            [self.btnRepeate setSelected:NO];
        }
        
        //shuffle
        if(status.shuffle == 1) {
            [self.btnShuffle setSelected:YES];
        }
        else {
            [self.btnShuffle setSelected:NO];
        }
        
        //play
        if([status.playStatus isEqualToString:@"1"]) {
            [self.btnPlay setSelected:YES];
        }
        else {
            [self.btnPlay setSelected:NO];
        }
        playButtonUpdateInterval = 0;
    }
}



#pragma ---------------
#pragma volumeControl

-(void) volumeControlUp:(int)args 
{
    [[ControllerManager getInstance] sendCommand:VolUp control:controlID args:[NSString stringWithFormat:@"%d",args]];
}

-(void) volumeControlDown:(int)args
{
    [[ControllerManager getInstance] sendCommand:VolDown control:controlID args:[NSString stringWithFormat:@"%d",args]];
}

-(void) volumeControlMute:(int)args
{
    [[ControllerManager getInstance] sendCommand:Mute control:controlID args:[NSString stringWithFormat:@"%d",args]];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.parentViewController); 
    NSLog(@"navigationController=%@",self.navigationController); 
    [self initNavigationStyle];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[ControllerManager getInstance] startPoolPlayStatus:controlID delegate:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [[ControllerManager getInstance] setDelegateData:nil];
    [[ControllerManager getInstance] stopPoolPlayStatus:controlID];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void) dealloc
{
    [btnPlay release];
    [volumeControl release];
    [super dealloc];
}

@end
