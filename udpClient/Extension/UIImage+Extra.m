//
//  UIImage+Extra.m
//  msdIpad
//
//  Created by ykm dev on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Extra.h"


@implementation UIImage (Extra)

+(UIImage*) imageFromMainBundleFile:(NSString*)aFileName {
	NSString *bundlePath = [[NSBundle mainBundle] pathForResource:aFileName ofType:nil];
	return [UIImage imageWithContentsOfFile:bundlePath];
}

+(UIImage*) imageFromURL:(NSString*)aFilePath {
	NSURL *url = [NSURL URLWithString:aFilePath];
	NSData *data = [NSData dataWithContentsOfURL:url];
	return [[[UIImage alloc] initWithData:data] autorelease];
}

@end
