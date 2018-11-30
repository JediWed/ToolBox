//
//  TBLoginView.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import UIKit

public protocol TBLoginViewDatasource: class {
    func placeholderForLoginfield() -> String?
    func textForLoginfield() -> String?
    func placeholderForPaswordfield() -> String?
    func textForPasswordfield() -> String?
    func titleForLoginButton() -> String?
    func mainColor() -> UIColor?
    func logoView() -> UIView?
}

public protocol TBLoginViewDelegate: class {
    func loginButtonPressed(loginButton: TBLoadingButton, login: String?, password: String?)
}

public class TBLoginView: UIView {

    public weak var delegate: TBLoginViewDelegate? {
        didSet {
            setupView()
        }
    }

    public weak var datasource: TBLoginViewDatasource? {
        didSet {
            setupView()
        }
    }

    fileprivate let loginCointainer: UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    fileprivate let usernameField: UITextField = {
        let textf = UITextField()
        textf.translatesAutoresizingMaskIntoConstraints = false
        textf.borderStyle = .roundedRect
        textf.layer.cornerRadius = 5
        textf.layer.borderWidth = 1
        textf.layer.masksToBounds = true
        return textf
    }()

    fileprivate let passwordField: UITextField = {
        let textf = UITextField()
        textf.isSecureTextEntry = true
        textf.translatesAutoresizingMaskIntoConstraints = false
        textf.borderStyle = .roundedRect
        textf.layer.cornerRadius = 5
        textf.layer.borderWidth = 1
        textf.layer.masksToBounds = true
        return textf
    }()

    fileprivate let loginButton: TBLoadingButton = {
        let wlb = TBLoadingButton()
        wlb.translatesAutoresizingMaskIntoConstraints = false
        wlb.backgroundColor = .clear
        wlb.layer.cornerRadius = 5
        wlb.layer.borderWidth = 1
        wlb.addTarget(nil, action: #selector(loginButtonAction), for: .touchUpInside)
        return wlb
    }()

    fileprivate var logoView: UIView?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }

    init() {
        super.init(frame: CGRect.zero)
        initialSetup()
    }

    fileprivate func initialSetup() {
        self.backgroundColor = .white
        [usernameField, passwordField].forEach { $0.delegate = self }
        loginCointainer.addSubview(usernameField)
        loginCointainer.addSubview(passwordField)
        loginCointainer.addSubview(loginButton)
        self.addSubview(loginCointainer)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)

        setupConstraints()
    }

    fileprivate func setupView() {
        self.usernameField.placeholder = self.datasource?.placeholderForLoginfield()
        self.usernameField.text = self.datasource?.textForLoginfield()
        self.passwordField.placeholder = self.datasource?.placeholderForPaswordfield()
        self.passwordField.text = self.datasource?.textForPasswordfield()
        self.loginButton.setTitle(self.datasource?.titleForLoginButton(), for: .normal)

        let mainColor = self.datasource?.mainColor() ?? UIColor.black
        self.usernameField.layer.borderColor = mainColor.withAlphaComponent(0.5).cgColor
        self.passwordField.layer.borderColor = mainColor.withAlphaComponent(0.5).cgColor
        self.loginButton.layer.borderColor = mainColor.withAlphaComponent(0.5).cgColor
        self.loginButton.setTitleColor(mainColor, for: .normal)

        if let logoView = self.datasource?.logoView() {
            self.logoView?.removeFromSuperview()
            self.logoView = logoView
            logoView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(logoView)
            self.addConstraints([
                NSLayoutConstraint(item: logoView, attribute: .centerX, relatedBy: .equal,
                                   toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: logoView, attribute: .width, relatedBy: .equal,
                                   toItem: self, attribute: .width, multiplier: 1, constant: -.tbSpacingLarge),
                NSLayoutConstraint(item: logoView, attribute: .top, relatedBy: .equal,
                                   toItem: self, attribute: .top, multiplier: 1, constant: .tbSpacingLarge),
                NSLayoutConstraint(item: logoView, attribute: .bottom, relatedBy: .equal,
                                   toItem: loginCointainer, attribute: .top, multiplier: 1, constant: -.tbSpacingLarge)
                ])
        }
    }

    fileprivate func setupConstraints() {

        loginCointainer.addConstraints([
            NSLayoutConstraint(item: usernameField, attribute: .top, relatedBy: .equal,
                               toItem: loginCointainer, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: usernameField, attribute: .leading, relatedBy: .equal,
                               toItem: loginCointainer, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: usernameField, attribute: .trailing, relatedBy: .equal,
                               toItem: loginCointainer, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: passwordField, attribute: .top, relatedBy: .equal,
                               toItem: usernameField, attribute: .bottom, multiplier: 1, constant: .tbSpacingMiddle),
            NSLayoutConstraint(item: passwordField, attribute: .leading, relatedBy: .equal,
                               toItem: loginCointainer, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: passwordField, attribute: .trailing, relatedBy: .equal,
                               toItem: loginCointainer, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal,
                               toItem: passwordField, attribute: .bottom, multiplier: 1, constant: .tbSpacingMiddle),
            NSLayoutConstraint(item: loginButton, attribute: .leading, relatedBy: .equal,
                               toItem: loginCointainer, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loginButton, attribute: .trailing, relatedBy: .equal,
                               toItem: loginCointainer, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loginButton, attribute: .bottom, relatedBy: .equal,
                               toItem: loginCointainer, attribute: .bottom, multiplier: 1, constant: 0)
            ])

        self.addConstraints([
            NSLayoutConstraint(item: loginCointainer, attribute: .centerX, relatedBy: .equal,
                               toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loginCointainer, attribute: .centerY, relatedBy: .equal,
                               toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loginCointainer, attribute: .width, relatedBy: .equal,
                               toItem: self, attribute: .width, multiplier: 0.5, constant: 0),
            NSLayoutConstraint(item: loginCointainer, attribute: .width, relatedBy: .equal,
                               toItem: self, attribute: .width, multiplier: 0.5, constant: 0)
            ])
    }

    @objc fileprivate func loginButtonAction(sender: TBLoadingButton) {
        self.delegate?.loginButtonPressed(loginButton: sender, login: usernameField.text, password: passwordField.text)
    }

    @objc fileprivate func dismissKeyboard () {
        [usernameField, passwordField].forEach {
            if $0.isFirstResponder {
                $0.resignFirstResponder()
            }
        }
    }

    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyBoardY = self.frame.height - keyboardSize.height
            let activeTextField = usernameField.isFirstResponder ? usernameField : passwordField
            let activeTextFieldY = loginCointainer.convert(activeTextField.frame, to: self).origin.y + activeTextField.frame.height
            let diffY = keyBoardY - activeTextFieldY - .tbSpacingMiddle
            if diffY < 0 {
                self.frame.origin.y += diffY
            }
        }
    }

    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        if self.frame.origin.y != 0 {
            self.frame.origin.y = 0
        }
    }

}

extension TBLoginView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameField:
            passwordField.becomeFirstResponder()
        case passwordField:
            passwordField.resignFirstResponder()
            loginButtonAction(sender: loginButton)
        default:
            break
        }
        return false
    }
}
