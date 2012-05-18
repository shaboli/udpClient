//
//  UIImage+Extra.h
//  msdIpad
//
//  Created by ykm dev on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Extra)

+(UIImage*) imageFromURL:(NSString*)aFilePath;
+(UIImage*) imageFromMainBundleFile:(NSString*)aFileName;


@end
