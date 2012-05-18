//
//  UICustomBarImageItem.h
//  isracard
//
//  Created by ykm dev on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UICustomBarImageItem : UIBarButtonItem {
	UIImageView *imageView;
}

@property (nonatomic, retain) UIImageView *imageView;

-(id)initWithImage:(UIImage*)image;

@end
