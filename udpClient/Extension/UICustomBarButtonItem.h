//
//  UICustomBarButtonItem.h
//  eldan2
//
//  Created by YKM on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    UICustomBarButtonItemTypeLeft = 0,
    UICustomBarButtonItemTypeRight = 1,
    UICustomBarButtonItemTypePlain = 2,
} UICustomBarButtonItemType;

@interface UICustomBarButtonItem : UIBarButtonItem {
	UIButton *button;
}

@property (nonatomic, retain) UIButton *button;

-(id)initWithCustomStyle:(UIImage*)image;
-(id)initWithCustomStyle:(NSString*)title withType:(UICustomBarButtonItemType)type;
-(void)setMyTitle:(NSString *)newTitle;

@end
