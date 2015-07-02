//
//  TLControllerNormalDismissAnimation.m
//  AutoRadio
//
//  Created by ZanderHo on 15/5/8.
//  Copyright (c) 2015年 ZanderHo. All rights reserved.
//

#import "TLControllerNormalDismissAnimation.h"
#import <pop/POP.h>

@interface TLControllerNormalDismissAnimation ()

@property (strong, nonatomic) UIView *maskView;

@end

@implementation TLControllerNormalDismissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:self.maskView];
    [containerView sendSubviewToBack:_maskView];
    _maskView.alpha = 0.8f;
    
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];

//    POPBasicAnimation *downAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
//    downAnimation.toValue = [NSValue valueWithCGRect:finalFrame];
//    [fromVC.view pop_addAnimation:downAnimation forKey:@"controllerDownAnimation"];
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        
        fromVC.view.frame = finalFrame;
        _maskView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        [_maskView removeFromSuperview];
        self.maskView = nil;
        
    }];
}


#pragma mark - getter and setter

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
    }
    
    return _maskView;
}

@end
