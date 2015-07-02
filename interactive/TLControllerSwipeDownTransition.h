//
//  TLControllerSwipeDownTransition.h
//  AutoRadio
//
//  Created by ZanderHo on 15/5/8.
//  Copyright (c) 2015年 ZanderHo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TLControllerSwipeDownTransition : UIPercentDrivenInteractiveTransition

@property (assign, nonatomic) BOOL interacting;

- (void)boundPresentingController:(UIViewController *)presenting presentedController:(UIViewController *)presented;

@end

