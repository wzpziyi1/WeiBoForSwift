//
//  ZYPoperAnimation.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/3.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYPoperAnimation: NSObject,  UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    //presentedView的尺寸
    var presentFrame: CGRect = CGRectZero
    
    //是否应该要展示
    dynamic var isPresenting: Bool = false
    
    var duration: NSTimeInterval = 0.5
    
    
    //MARK: ----UIViewControllerTransitioningDelegate
    
     // 实现代理方法, 告诉系统谁来负责转场动画
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        let vc = ZYPresentationController(presentedViewController: presented, presentingViewController: presenting)
        vc.presentFrame = presentFrame
        return vc
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresenting = false
        return self
    }
    
    
    //MARK: ----UIViewControllerAnimatedTransitioning
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return duration
    }
    
    
    /**
     告诉系统如何动画, 无论是展现还是消失都会调用这个方法
     
     - parameter transitionContext: 上下文, 里面保存了动画需要的所有参数
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        if (isPresenting)
        {
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            toView?.transform = CGAffineTransformMakeScale(1.0, 0)
            
            toView?.layer.anchorPoint = CGPointMake(0.5, 0)
            
            // 注意: 一定要将视图添加到容器上
            transitionContext.containerView()?.addSubview(toView!)
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                toView?.transform = CGAffineTransformIdentity
                }, completion: { (_) -> Void in
                    //一定要提醒系统动画完成，否则可能产生未知错误
                    transitionContext.completeTransition(true)
            })
        }
        else
        {
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            fromView?.layer.anchorPoint = CGPointMake(0.5, 0)
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                // 注意:由于CGFloat是不准确的, 所以如果写0.0会没有动画
                fromView?.transform = CGAffineTransformMakeScale(1.0, 0.0000001)
                }, completion: { (_) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
    }
    
}
