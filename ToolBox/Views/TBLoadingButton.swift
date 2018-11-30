//
//  TBLoadingButton.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import UIKit

public class TBLoadingButton: UIButton {

    public var isAnimating = false

    fileprivate var originalButtonText: String?
    fileprivate var initialized = false

    fileprivate var activityIndicator: UIActivityIndicatorView = {
        let aci = UIActivityIndicatorView()
        aci.hidesWhenStopped = true
        aci.color = .lightGray
        aci.translatesAutoresizingMaskIntoConstraints = false
        return aci
    }()

    public func startAnimating() {
        initializeButton()
        originalButtonText = self.titleLabel?.text
        self.setTitle(nil, for: .normal)
        activityIndicator.startAnimating()
        isAnimating = true
    }

    public func stopAnimating() {
        self.setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
        isAnimating = false
    }

    private func initializeButton() {
        if !initialized {
            self.addSubview(activityIndicator)

            addConstraints([
                NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal,
                                   toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal,
                                   toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
                ])

            initialized = true
        }
    }
}
