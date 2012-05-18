//
//  UICustomDatePicker.m
//  eldan2
//
//  Created by YKM on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UICustomDatePicker.h"


@implementation UICustomDatePicker

@synthesize datePicker, delegate, controlTarget;

-(id) initWithCustomStyle:(NSString*)title {
	if(self = [super initWithTitle:@"" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]) {
		self.backgroundColor = [UIColor clearColor];
		
		datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
		datePicker.datePickerMode = UIDatePickerModeDate;
		datePicker.backgroundColor = [UIColor clearColor];
		
        UIToolbar *pickerDateToolbar = [[UIToolbar alloc] init];
        if([pickerDateToolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
            UIImage *image = [UIImage imageNamed:@"navBar_back.png"];
            [pickerDateToolbar setBackgroundImage:image forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        }
        [pickerDateToolbar setBarStyle:UIBarStyleBlackTranslucent];
        [pickerDateToolbar sizeToFit];
		
		NSMutableArray *barItems = [[NSMutableArray alloc] init];
		UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@" סגור " style:UIBarButtonItemStyleBordered target:self action:@selector(closeDatePicker)];
		[barItems addObject:cancelBtn];
		
		UIBarButtonItem *flexSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
		[barItems addObject:flexSpace1];
		
		UILabel *label = [[UILabel alloc] init];
		label.text = title;
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor clearColor];
		[label setFont:[UIFont fontWithName:@"Thonburi-Bold" size:16]];
        label.textColor = [UIColor colorWithRed:21.0/255.0 green:71.0/255.0 blue:110.0/255.0 alpha:1.0];
		[label sizeToFit];
		UIBarButtonItem *toolBarTitle = [[UIBarButtonItem alloc] initWithCustomView:label];
		[label release];
		[barItems addObject:toolBarTitle];
		
		UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
		[barItems addObject:flexSpace];

		UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@" בחר " style:UIBarButtonItemStyleDone target:self action:@selector(dateSelected:)];
		[barItems addObject:doneBtn];
		
		[pickerDateToolbar setItems:barItems animated:NO];
		[self addSubview:pickerDateToolbar];
		[self addSubview:datePicker];
		
		[pickerDateToolbar release];
		[barItems release];
		[cancelBtn release];
		[flexSpace release];
		[flexSpace1 release];
		[doneBtn release];
		[toolBarTitle release];
	}
	return self;
}

-(void) closeDatePicker
{
	[super dismissWithClickedButtonIndex:0 animated:YES];
	[self.delegate datePickerDateCanceledWithTarget:controlTarget];
}

-(void) dateSelected:(id)dender
{
	[super dismissWithClickedButtonIndex:0 animated:YES];
	[self.delegate datePickerDateSelected:datePicker.date target:controlTarget];
}

-(void) showInView:(UIView*)view
{
	[super showInView:view];
	[super setBounds:CGRectMake(0,0,320,485)];
}

- (void)dealloc {
	[datePicker release];
	[super dealloc];
}

@end
