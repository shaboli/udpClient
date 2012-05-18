//
//  UIAlertViewHelper.h
//  isracard
//
//  Created by ykm dev on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * Convenience method to throw a quick alert to the user
 * Runs LocalizedString() on all strings
 */
void UIAlertViewQuick(NSString* title, NSString* message, NSString* dismissButtonTitle);

@interface UIAlertView (Helper)

+ (id)presentAlertViewWithTitle:(NSString*)aTitle message:(NSString*)aMessage delegate:(id)object;
+ (id)presentAlertViewWithTitle:(NSString*)aTitle message:(NSString*)aMessage delegate:(id)object otherButtonTitle:(NSString *)otherButtonTitle;
+ (id)presentConfirmAlertViewWithTitle:(NSString*)aTitle message:(NSString*)aMessage cancelButtonTitle:(NSString*)cancel otherButtonTitles:(NSString*)other delegate:(id)object;

//Specific Alerts
+ (id)presentNoInternetAlertWithDelegate:(id)object;

+ (id)presentIncorrectPasswordAlertWithDelegate:(id)object;

+ (id)presentDialogForMissingField:(NSString*)fieldName;

+ (id)presentDialogForWifiUnreachabilityWithDelegate:(id)object;

+ (id)presentDialogForWifiRecheckWithDelegate:(id)object;

+ (id)presentErrorinAlertView:(NSError*)error;

+ (id)presentErrorinAlertView:(NSError*)error delegate:(id)object;

+ (id)presentAlertViewWithLocalNotification:(UILocalNotification*)notification delegate:(id)object;

+ (id)presentConfirmAlertViewWithTitle:(NSString*)aTitle message:(NSString*)aMessage delegate:(id)object;

@end
