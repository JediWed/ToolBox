//
//  TBLoginViewController.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import UIKit

open class TBLoginViewController: UIViewController, TBLoginViewDelegate, TBLoginViewDatasource {

    override open func viewDidLoad() {
        super.viewDidLoad()
        let loginView = TBLoginView(frame: view.frame)
        loginView.delegate = self
        loginView.datasource = self
        view = loginView
    }

    // MARK: - TBLoginViewDatasource

    open func placeholderForLoginfield() -> String? {
        return nil
    }

    open func textForLoginfield() -> String? {
        return nil
    }

    open func placeholderForPaswordfield() -> String? {
        return nil
    }

    open func textForPasswordfield() -> String? {
        return nil
    }

    open func titleForLoginButton() -> String? {
        return nil
    }

    open func mainColor() -> UIColor? {
        return nil
    }

    open func logoView() -> UIView? {
        return nil
    }

    // MARK: - TBLoginViewDelegate

    open func loginButtonPressed(loginButton: TBLoadingButton, login: String?, password: String?) {

    }
}
