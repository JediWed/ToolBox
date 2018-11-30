//
//  TBStepperTableViewCell.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import UIKit

public class TBStepperTableViewCell: UITableViewCell {

    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 99
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    private let countTextField: UITextField = UITextField()

    public var onChange: ((Int) -> Void)?

    public var value: Int = 0 {
        didSet {
            countTextField.text = String(value)
            stepper.value = Double(value)
        }
    }

    public var isEnabled: Bool = true {
        didSet {
            self.isUserInteractionEnabled = isEnabled
            if oldValue != isEnabled && isEnabled {
                stepper.alpha = 1
            } else if oldValue != isEnabled && !isEnabled {
                stepper.alpha = 0.5
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true

        countTextField.borderStyle = .roundedRect
        countTextField.textAlignment = .center
        countTextField.translatesAutoresizingMaskIntoConstraints = false

        let container = UIView()
        container.addSubview(countTextField)
        container.addSubview(stepper)
        NSLayoutConstraint.activate([
            countTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            countTextField.topAnchor.constraint(equalTo: container.topAnchor),
            countTextField.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            countTextField.widthAnchor.constraint(equalToConstant: .tbStepperTextFieldWidth),
            stepper.leadingAnchor.constraint(equalTo: countTextField.trailingAnchor, constant: .tbSpacingSmall),
            stepper.topAnchor.constraint(equalTo: container.topAnchor),
            stepper.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            stepper.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            ])
        container.frame.size = container.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        stepper.addTarget(self, action: #selector(stepperDidChange), for: .valueChanged)
        countTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        countTextField.delegate = self

        accessoryView = container
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func stepperDidChange() {
        countTextField.resignFirstResponder()
        value = Int(stepper.value)
        countTextField.text = String(value)
        onChange?(value)
    }

    @objc private func textFieldDidChange() {
        guard let text = countTextField.text, let value = Int(text) else {
            return
        }
        self.value = value
        stepper.value = Double(value)
        onChange?(value)
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        onChange = nil
    }

    public override func becomeFirstResponder() -> Bool {
        return countTextField.becomeFirstResponder()
    }
}

extension TBStepperTableViewCell: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if let text = textField.text, let value = Int(text) {
            self.value = value
        } else {
            onChange?(self.value)
        }
        return true
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text, let value = Int(text) else {
            return false
        }
        self.value = value.tbClamped(to: Int(stepper.minimumValue)...Int(stepper.maximumValue))
        return true
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.isEmpty || Int(newString) != nil && newString.count < 3
    }
}
