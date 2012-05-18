//
//  UINavigationBar.h
//  eldan2
//
//  Created by YKM on 7/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UICustomBarButtonItem.h"
#import <MessageUI/MessageUI.h>

@interface UINavigationBar (UINavigationBarCustom)

-(void) initWithCustomStyle:(UIViewController*)target withTitle:(NSString*)title;
-(void) initWithCustomStyle:(UIViewController*)target withImage:(NSString*)imageName;
-(void) initWithCustomStyle:(UIViewController*)target withImage:(NSString*)imageName title:(NSString*)title;
-(void) setButtons:(UIViewController*)target WithLeft:(UIBarButtonItem*)leftButton AndRight:(UIBarButtonItem*)rightButton;

@end
