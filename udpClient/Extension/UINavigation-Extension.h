//
//  UINavigation-Extension.h
//  isracard
//
//  Created by ykm dev on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface UINavigationController (Extension)

-(void) pushController:(UIViewController*)controller withTransition:(UIViewAnimationTransition)transition;
-(void) pushHEController:(UIViewController*)controller;
-(void) popHEController;

@end
