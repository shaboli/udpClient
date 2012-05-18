//
//  UICustomBarImageItem.m
//  isracard
//
//  Created by ykm dev on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UICustomBarImageItem.h"

@implementation UICustomBarImageItem

@synthesize imageView;

-(id)initWithImage:(UIImage*)image {
	if(self = [super init]) {
		imageView = [[UIImageView alloc] init];
        [imageView setImage:image];
		[imageView setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
		
		[self initWithCustomView:imageView];
	}
	return self;
}


@end
