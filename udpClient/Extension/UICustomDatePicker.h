//
//  UICustomDatePicker.h
//  eldan2
//
//  Created by YKM on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICustomBarButtonItem.h"

@protocol UICustomDatePikerDelegete<NSObject>
-(void) datePickerDateSelected:(NSDate*)date target:(int)control;
-(void) datePickerDateCanceledWithTarget:(int)control;
@end

@interface UICustomDatePicker : UIActionSheet {

	UIDatePicker *datePicker;
	id<UICustomDatePikerDelegete> delegate;
	int controlTarget;
}

@property (nonatomic,retain) UIDatePicker *datePicker;
@property (nonatomic,assign) id delegate;
@property (nonatomic) int controlTarget;

-(id) initWithCustomStyle:(NSString*)title;
-(void) showInView:(UIView*)view;

@end
