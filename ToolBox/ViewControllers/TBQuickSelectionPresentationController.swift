//
//  TBQuickSelectionPresentationController.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import UIKit

public class TBQuickSelectionPresentationController: UIPresentationController {
    public var customHeight: CGFloat = 0.0
    fileprivate var dimmingView: UIView!

    override public func presentationTransitionWillBegin() {
        dimmingView = UIView()
        self.dimmingView.translatesAutoresizingMaskIntoConstraints = false
        self.dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        self.dimmingView.alpha = 0.0
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTap))
        dimmingView.addGestureRecognizer(recognizer)
        dimmingView.isUserInteractionEnabled = true

        containerView?.insertSubview(dimmingView, at: 0)

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))

        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }

    override public func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            self.dimmingView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }

    @objc func dimmingViewTap() {
        presentingViewController.dismiss(animated: true)
    }

    override public var frameOfPresentedViewInContainerView: CGRect {

        if customHeight <= 0.0 {
            customHeight = (containerView?.bounds.height)!
        } else if customHeight > (containerView?.bounds.height)! {
            customHeight = (containerView?.bounds.height)!
            if let pvc = presentedViewController as? UITableViewController {
                pvc.tableView.isScrollEnabled = true
            }
        }

        let width = (containerView!.bounds.width > CGFloat.tbQuickSelectionMaxWidth)
            ? CGFloat.tbQuickSelectionMaxWidth : containerView!.bounds.width

        if width < containerView!.bounds.width {
            let view = self.presentedViewController.view
            self.presentedViewController.view.bounds = CGRect(x: (view?.frame.origin.x)!,
                                                              y: (view?.frame.origin.y)!,
                                                              width: width,
                                                              height: customHeight)
            self.presentedViewController.view.tbRounded(corners: [.topLeft, .topRight], radius: 4.0)
        }

        return CGRect(x: (containerView!.bounds.width - width) / 2.0,
                      y: containerView!.bounds.height - customHeight,
                      width: width,
                      height: customHeight)
    }
}
