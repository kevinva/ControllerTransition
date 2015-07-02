//
//  TLControllerSwipeDownTransition.m
//  AutoRadio
//
//  Created by ZanderHo on 15/5/8.
//  Copyright (c) 2015年 ZanderHo. All rights reserved.
//

#import "TLControllerSwipeDownTransition.h"

@interface TLControllerSwipeDownTransition () <UIGestureRecognizerDelegate>

@property (assign, nonatomic) BOOL shouldComplete;
@property (strong, nonatomic) UIViewController *presentingVC;
@property (strong, nonatomic) UIViewController *presentedVC;


@end

@implementation TLControllerSwipeDownTransition

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

#pragma mark - Public interfaces

- (void)boundPresentingController:(UIViewController *)presenting presentedController:(UIViewController *)presented {
    self.presentedVC = presented;
    self.presentingVC = presenting;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(_handlePan:)];
    //    panGesture.delegate = self;
    [_presentedVC.view addGestureRecognizer:panGesture];
}

#pragma mark - UIPanGestureRecognizer callback

- (void)_handlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:gesture.view.superview];    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.interacting = YES;
            [_presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:{
            CGFloat fraction = translation.y / _presentingVC.view.bounds.size.height;
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.4);
            
            [self updateInteractiveTransition:fraction];
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            self.interacting = NO;
            if (!_shouldComplete || gesture.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            }
            else {
                [self finishInteractiveTransition];
            }
            break;
        }
            
        default:
            break;
    }
}


//#pragma mark - UIGestureRecognizerDelegate
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

@end
