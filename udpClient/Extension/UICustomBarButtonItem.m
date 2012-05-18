//
//  UICustomBarButtonItem.m
//  eldan2
//
//  Created by YKM on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UICustomBarButtonItem.h"


@implementation UICustomBarButtonItem

@synthesize button;

-(id)initWithCustomStyle:(NSString*)title withType:(UICustomBarButtonItemType)type {
	if(self = [super init]) {
		button = [[UIButton alloc] init];
		[button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
		[button setTitle:title forState:UIControlStateNormal];
		[button setTitleColor:[UIColor colorWithRed:21.0/255.0 green:71.0/255.0 blue:110.0/255.0 alpha:1.0] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		UIFont *buttonFont = [UIFont fontWithName:@"AlchemistBold" size:14];
		button.titleLabel.font = buttonFont;
		CGSize stringBounding = [title sizeWithFont:buttonFont];
		button.frame = CGRectMake(0, 0, fmax(stringBounding.width + 20.0, 55), 32.0);
		
		UIImage *image;
		switch (type) {
			case UICustomBarButtonItemTypeLeft:
				image = [UIImage imageNamed:@"button_left.png"];
				[button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
				break;
			case UICustomBarButtonItemTypeRight:
				image = [UIImage imageNamed:@"button_right.png"];
				break;
			default:
				image = [UIImage imageNamed:@"button_def.png"];
				
				UIImage *defSelection = [UIImage imageNamed:@"button_def_red.png"];
				UIImage *selectStretchImage = [defSelection stretchableImageWithLeftCapWidth:25.0 topCapHeight:0.0];
				[button setBackgroundImage:selectStretchImage forState:UIControlStateSelected];
				break;
		}
		
		UIImage *stretchImage = [image stretchableImageWithLeftCapWidth:25.0 topCapHeight:0.0];
		[button setBackgroundImage:stretchImage forState:UIControlStateNormal];
		[self initWithCustomView:button];
	}
	return self;
}

-(id)initWithCustomStyle:(UIImage*)image {
	if(self = [super init]) {
		button = [[UIButton alloc] init];		
		[button setBackgroundImage:image forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
		[self initWithCustomView:button];
	}
	return self;
}

-(void)setMyTitle:(NSString *)newTitle {
	[button setTitle:newTitle forState:UIControlStateNormal];
}

- (void)dealloc {
    [button release];
    [super dealloc];
}

@end
