//
//  UINavigationBar.m
//  eldan2
//
//  Created by YKM on 7/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+UINavigationBarCustom.h"

#define TAG_STYLE 12345

@implementation UINavigationBar (UINavigationBarCustom)

-(void) initWithCustomStyle:(UIViewController*)target withTitle:(NSString*)title {
	[self setBarStyle:UIBarStyleDefault];
    self.tag = TAG_STYLE;
    if([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *image = [UIImage imageNamed:@"nav2_back.png"];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 185.0f, 20.0f)];
	[label setFont:[UIFont fontWithName:@"AlchemistBold" size:18]];
	label.textColor = [UIColor whiteColor];
    [label setMinimumFontSize:14.0];
    [label setAdjustsFontSizeToFitWidth:YES];
    CGSize stringBounding = [title sizeWithFont:label.font];
    label.frame = CGRectMake(0, 0, fmin(stringBounding.width, 185.0), 20.0);
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextAlignment:UITextAlignmentCenter];
	[label setText:title];
	[[target navigationItem] setTitleView:label]; 
	[label release];
}

-(void) initWithCustomStyle:(UIViewController*)target withImage:(NSString*)imageName {
	[self setBarStyle:UIBarStyleDefault];
	self.tag = TAG_STYLE;
    if([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *image = [UIImage imageNamed:imageName];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
}

-(void) initWithCustomStyle:(UIViewController*)target withImage:(NSString*)imageName title:(NSString*)title {
	[self setBarStyle:UIBarStyleDefault];

    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	[label setFont:[UIFont fontWithName:@"AlchemistBold" size:18]];
	label.textColor = [UIColor whiteColor];
    [label setMinimumFontSize:14.0];
    [label setAdjustsFontSizeToFitWidth:YES];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextAlignment:UITextAlignmentCenter];
	[label setText:title];
    [label sizeToFit];
    [[target navigationItem] setTitleView:label]; 
    
    if([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *image = [UIImage imageNamed:imageName];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
}

-(void) setButtons:(UIViewController*)target WithLeft:(UIBarButtonItem*)leftButton AndRight:(UIBarButtonItem*)rightButton {
	if(leftButton != nil) {
		target.navigationItem.leftBarButtonItem = leftButton;
	}
	else {
		UIBarButtonItem *fakeLeft = [[UIBarButtonItem alloc] initWithCustomView:[[[UIView alloc] initWithFrame:CGRectMake(0, 0, 71, 1)] autorelease]];
		fakeLeft.enabled = NO;
		target.navigationItem.leftBarButtonItem = fakeLeft;
		[fakeLeft release];
	}
	if(rightButton != nil) {
		target.navigationItem.rightBarButtonItem = rightButton;
	}
	else {
		UIBarButtonItem *fakeRight = [[UIBarButtonItem alloc] initWithCustomView:[[[UIView alloc] initWithFrame:CGRectMake(0, 0, 71, 1)] autorelease]];
		fakeRight.enabled = NO;
		target.navigationItem.rightBarButtonItem = fakeRight;
		[fakeRight release];		
	}
}


@end
