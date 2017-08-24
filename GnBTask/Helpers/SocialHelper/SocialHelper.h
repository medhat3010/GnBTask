//
//  SocialHelper.h
//  GnBTask
//
//  Created by Medhat Mohamed on 8/22/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>


@interface SocialHelper : NSObject

+(void)shareToTwitterWithDescription:(NSString *)description andImage:(UIImage *) image;

@end
