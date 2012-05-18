//
//  BsPlayerController.h
//  udpClient
//
//  Created by User on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DiscoveryUDP.h"
#import "Server.h"
#import "ControllerManager.h"
#import "VolumeControl.h"
#import "BaseController.h"

@interface BsPlayerController : BaseController <ControllerManagerDataProtocol, VolumeControlDelegate> {
    IBOutlet UIButton *btnPlay;
    IBOutlet UIButton *btnShuffle;
    IBOutlet UIButton *btnRepeate;
    
    IBOutlet UILabel *lblPlayLength;
    IBOutlet UILabel *lblPlayCurrentPotition;
    IBOutlet VolumeControl *volumeControl;
    IBOutlet UILabel *lblTrackPosition;
    IBOutlet UILabel *lblTrackName;
    IBOutlet UISlider *trackSlider;
    
    BOOL isSliderTouched;
    int playButtonUpdateInterval;
}

@property(nonatomic,retain) IBOutlet UIButton *btnShuffle;
@property(nonatomic,retain) IBOutlet UIButton *btnRepeate;
@property(nonatomic,retain) IBOutlet UIButton *btnPlay;
@property(nonatomic,retain) IBOutlet UILabel *lblTrackPosition;
@property(nonatomic,retain) IBOutlet UILabel *lblTrackName;
@property(nonatomic,retain) IBOutlet UILabel *lblPlayLength;
@property(nonatomic,retain) IBOutlet UILabel *lblPlayCurrentPotition;
@property(nonatomic,retain) IBOutlet VolumeControl *volumeControl;
@property(nonatomic,retain) IBOutlet UISlider *trackSlider;

-(IBAction)controlClick:(id)sender;
-(IBAction)sliderValueChanged:(UISlider *)sender;

-(IBAction)playClick:(id)sender;
-(IBAction)shuffleClick:(id)sender;
-(IBAction)repeateClick:(id)sender;
-(IBAction)fullClick:(id)sender;

@end
