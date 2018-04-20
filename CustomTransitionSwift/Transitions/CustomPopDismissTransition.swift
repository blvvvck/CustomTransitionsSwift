//
//  CustomPopDismissTransition.swift
//  CustomTransitionSwift
//
//  Created by Ildar Zalyalov on 16.04.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class CustomPopDismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 5.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
            else { return }
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        containerView.addSubview(toViewController.view)
        containerView.sendSubview(toBack: toViewController.view)
        
        guard let snapShotView = fromController.view.snapshotView(afterScreenUpdates: true) else { return }
        
        snapShotView.frame = fromController.view.frame
        
        containerView.addSubview(snapShotView)
        
        fromController.view.removeFromSuperview()
    
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            var transform = CATransform3DIdentity
            let layer = snapShotView.layer
            
            transform.m34 = 1.0 / -500
            transform = CATransform3DRotate(transform, 45.0 * .pi / 180, 0.0, 1.0, 0.0)
            
            layer.transform = transform
            
        }) { (isFinished) in
            
            snapShotView.removeFromSuperview()
            transitionContext.completeTransition(isFinished)
        }
    }
}
