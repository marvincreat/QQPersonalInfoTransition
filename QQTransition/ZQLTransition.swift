//
//  ZQLTransition.swift
//  QQTransition
//
//  Created by 臧其龙 on 15/6/8.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

import UIKit

let kAnimationDuration = 4

class ZQLTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isReverse:Bool = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return NSTimeInterval(kAnimationDuration)
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if !isReverse{
            var fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            var toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            
            var containerView:UIView = transitionContext.containerView()
            
            var screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
            
            var animationDuration:NSTimeInterval = self.transitionDuration(transitionContext)
            
            toVC?.view.transform = CGAffineTransformMakeTranslation(screenWidth, 0)
            
            if let viewcontroller = toVC{
                containerView.addSubview(viewcontroller.view)
            }
            
            if let navgationController = fromVC?.navigationController{
                UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                    navgationController.navigationBar.alpha = 0
                    toVC?.view.transform = CGAffineTransformIdentity
                    }, completion: { (completion:Bool) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                })
            }

        }else{
            var fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            var toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            
            var containerView:UIView = transitionContext.containerView()
            
            var screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
            
            var animationDuration:NSTimeInterval = self.transitionDuration(transitionContext)
            
             containerView.insertSubview(toVC!.view, belowSubview: fromVC!.view)
            
            if let navgationController = fromVC?.navigationController{
                
                UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                    navgationController.navigationBar.alpha = 1
                    fromVC?.view.transform = CGAffineTransformMakeTranslation(screenWidth, 0)
                    }, completion: { (completion:Bool) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                })

            }
        }
    }
}
