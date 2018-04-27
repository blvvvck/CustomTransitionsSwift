//
//  CustomInteractor.swift
//  TransitionSwiftTest
//
//  Created by BLVCK on 25/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class CustomInteractor: UIPercentDrivenInteractiveTransition {
    
    var viewController: ViewController!
    var navigationController: UINavigationController
    var shouldCompleteTransition = false
    var transitionInProgress = false
    var viewTranslitonsSum: CGFloat = 0
    let dismissConstant: CGFloat = 0.7
    let animateDuration = 0.5
    
    init?(attachTo viewController : ViewController) {
        if let nav = viewController.navigationController {
            self.viewController = viewController
            self.navigationController = nav
            super.init()
            self.setupGesture(view: viewController.view)

        } else {
            return nil
        }
    }
    
    private func setupGesture(view : UIView) {
        let swipeUpGesture = UIPanGestureRecognizer(target: self, action: #selector(handleUpGesture(gesture:)))
        view.addGestureRecognizer(swipeUpGesture)
    }
    
    @objc private func handleUpGesture(gesture : UIPanGestureRecognizer) {
        guard let image = viewController.artworkImageView else { return }
        let viewTranslation = gesture.translation(in: gesture.view?.superview)

        //Comment this
        image.center = CGPoint(x: image.center.x, y: viewTranslation.y + image.center.y)
        //Uncomment this
        //var progress1 = viewTranslation.y / self.navigationController.view.frame.height
        
        //Comment this 5 lines
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let strongSelf = self else { return }
            let backgroundAlpha = (gesture.view?.superview?.center.y)! - image.center.y
            strongSelf.viewController.backgroundView.alpha = backgroundAlpha
        }

        switch gesture.state {
        case .began:
            transitionInProgress = true
            navigationController.popViewController(animated: true)

        case .changed:
            //Uncoment this 2 lines
            //shouldCompleteTransition = progress1 > 0.5
            //update(progress1)
            
            //Comment this 3 lines
            viewTranslitonsSum += viewTranslation.y
            var progress: CGFloat = abs(viewTranslitonsSum / 400)
            shouldCompleteTransition = progress > dismissConstant
            return
        case .cancelled:
            transitionInProgress = false
            if shouldCompleteTransition {
                cancel()
            }
        case .ended:
            transitionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
        default:
            return
        }
        gesture.setTranslation(CGPoint.zero, in: gesture.view?.superview)
        
    }
}
