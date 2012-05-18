//
//  UIToolbar+Custom.m
//  isracard
//
//  Created by ykm dev on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIToolbar+Custom.h"


@implementation UIToolbar (Custom)

-(void) drawRect:(CGRect )rect {
	UIImage *image = [UIImage imageNamed:@"navBar_back.png"];
	[image drawInRect:rect];
}

+(UIToolbar*) createKeyBoardBar:(id)delegate showNext:(BOOL)showNext showPrevious:(BOOL)showPrevious {
    UIToolbar *keyboardToolbar = [[[UIToolbar alloc] init] autorelease];
    [keyboardToolbar setBarStyle:UIBarStyleBlackTranslucent];
    if([keyboardToolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        UIImage *image = [UIImage imageNamed:@"navBar_back.png"];
        [keyboardToolbar setBackgroundImage:image forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    }
    [keyboardToolbar sizeToFit];
    
    //done button
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" סיום " style:UIBarButtonItemStyleDone target:delegate action:@selector(dismissKeyboard:)];
    //flex button
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //segment button
	UIBarButtonItem *controlItem = nil;
	if(showNext || showPrevious) {
		UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
																				 NSLocalizedString(@"הקודם",@"הקודם"),
																				 NSLocalizedString(@" הבא ",@"הבא"),                                         
																				 nil]];
		control.segmentedControlStyle = UISegmentedControlStyleBar;
		control.tintColor = [UIColor darkGrayColor];
		control.momentary = YES;
		[control setEnabled:showNext forSegmentAtIndex:1];
		[control setEnabled:showPrevious forSegmentAtIndex:0];
		[control addTarget:delegate action:@selector(nextPrevious:) forControlEvents:UIControlEventValueChanged];     
		controlItem = [[UIBarButtonItem alloc] initWithCustomView:control];
		[control release];
	}
	else {
		controlItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	}

    
    NSArray *items = [[NSArray alloc] initWithObjects:controlItem, flex, barButtonItem, nil];
    [keyboardToolbar setItems:items];
    [items release];
    
    [controlItem release];
    [barButtonItem release];
    [flex release];
     
    return keyboardToolbar;
}

@end
