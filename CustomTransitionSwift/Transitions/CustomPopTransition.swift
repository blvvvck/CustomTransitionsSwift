//
//  CustomPopTransition.swift
//  CustomTransitionSwift
//
//  Created by Ildar Zalyalov on 16.04.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class CustomPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromController = transitionContext.viewController(forKey: .from),
        let toViewController = transitionContext.viewController(forKey: .to)
            else { return }
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        containerView.addSubview(toViewController.view)
        
        toViewController.view.frame = finalFrame.offsetBy(dx: -bounds.width, dy: bounds.height)
        
        toViewController.view.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            toViewController.view.alpha = 1.0
            fromController.view.alpha = 0.0
            toViewController.view.frame = finalFrame
            
        }) { (isFinished) in
            
            fromController.view.alpha = 1.0
            transitionContext.completeTransition(isFinished)
        }
    }
    
    
}
