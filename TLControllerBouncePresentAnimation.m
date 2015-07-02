//
//  TLControllerBouncePresentAnimation.m
//  AutoRadio
//
//  Created by ZanderHo on 15/5/8.
//  Copyright (c) 2015年 ZanderHo. All rights reserved.
//

#import "TLControllerBouncePresentAnimation.h"
#import "Constants.h"
#import <pop/POP.h>


@implementation TLControllerBouncePresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {    
    //1. 得到目标viewController
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //2.初始化目标viewControlle的frame
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    
    //3.添加到containerView上
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    //4.做转场动画效果
    [toVC.view pop_removeAllAnimations];
    
    POPSpringAnimation *springAniamtion = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    springAniamtion.springSpeed = 40.0f;
    springAniamtion.springBounciness = 10.0f;
    springAniamtion.toValue = [NSValue valueWithCGRect:finalFrame];
    [springAniamtion setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
        
        [transitionContext completeTransition:YES];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kOnFinishPresentingControlerAnimation object:self];
        
    }];
    [toVC.view pop_addAnimation:springAniamtion forKey:@"controllerBounceAnimation"];
    
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    [UIView animateWithDuration:duration
//                          delay:0.0
//         usingSpringWithDamping:0.6
//          initialSpringVelocity:0.0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         
//                         toVC.view.frame = finalFrame;
//                         
//                     } completion:^(BOOL finished) {
//                         
//                         //5.完成
//                         [transitionContext completeTransition:YES];
//                         
//                     }];
}


@end
