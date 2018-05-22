//
//  TransitionAnimation.m
//  Project 13 - AnimatedTransitioning
//
//  Created by Jamie on 2018/5/22.
//  Copyright © 2018年 Jamie. All rights reserved.
//

#import "TransitionAnimation.h"

@implementation TransitionAnimation

//这个方法用来设置动画的播放时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

//这个方法来具体实现场景转换时，所需要实现的动画效果。
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //获取跳转前后的view
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //由于场景转换环境会自动添加fromVC到contrainer中，但是不会自动添加toVC，如果需要对toVC做动画特效需要自己手动添加。
    [transitionContext.containerView addSubview:toVC.view];

    //初始化toVC的alpha值为0
    toVC.view.alpha = 0;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1;
        fromVC.view.alpha = 0;
    }completion:^(BOOL finished) {
        fromVC.view.alpha = 1;
        [transitionContext completeTransition:YES];
    }];
}


@end
