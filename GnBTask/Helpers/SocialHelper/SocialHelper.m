//
//  SocialHelper.m
//  GnBTask
//
//  Created by Medhat Mohamed on 8/22/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import "SocialHelper.h"

@implementation SocialHelper

+(void)shareToTwitterWithDescription:(NSString *)description andImage:(UIImage *) image
{
    TWTRComposer *composer = [[TWTRComposer alloc] init];
    
    [composer setImage:image];
    [composer setText:description];
    [composer showFromViewController:[SocialHelper topMostController] completion:^(TWTRComposerResult result) {
        if (result == TWTRComposerResultCancelled) {
            NSLog(@"Tweet composition cancelled");
        }
        else {
            NSLog(@"Sending Tweet!");
        }
    }];
    
}

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}


@end
