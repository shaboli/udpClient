//
//  UINavigation-Extension.m
//  isracard
//
//  Created by ykm dev on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigation-Extension.h"


@implementation UINavigationController (Extension)

-(void) pushController:(UIViewController*)controller withTransition:(UIViewAnimationTransition)transition {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.33];
    [UIView setAnimationBeginsFromCurrentState:YES];        
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
	[self pushViewController:controller animated:NO];
    [UIView commitAnimations];
}

-(void) pushHEController:(UIViewController*)controller {
    CATransition* transition = [CATransition animation];
	transition.removedOnCompletion = YES;
	transition.duration = 0.4;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromLeft;
	[self.view.layer addAnimation:transition forKey:nil];
	[self pushViewController:controller animated:NO];
}

-(void) popHEController {
	CATransition* transition = [CATransition animation];
	transition.removedOnCompletion = YES;
	transition.duration = 0.4;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromRight;
	[self.view.layer addAnimation:transition forKey:nil];
	[self popViewControllerAnimated:NO];
}

@end
