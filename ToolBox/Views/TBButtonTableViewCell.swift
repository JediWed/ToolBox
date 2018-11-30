//
//  TBButtonTableViewCell.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import UIKit

public class TBButtonTableViewCell: UITableViewCell {

    public enum Style {
        case `default`
        case delete
    }

    public var style: Style = .default {
        didSet {
            updateTextColor()
        }
    }

    public var isEnabled: Bool = true {
        didSet {
            updateTextColor()
        }
    }

    public var action: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        textLabel?.textAlignment = .center
        textLabel?.textColor = tintColor
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func tintColorDidChange() {
        super.tintColorDidChange()
        updateTextColor()
    }

    private func updateTextColor() {
        switch style {
        case .default:
            textLabel?.textColor = tintColor
        case .delete:
            textLabel?.textColor = .red
        }
        if !isEnabled {
            textLabel?.textColor = textLabel?.textColor.withAlphaComponent(0.5)
        }
    }

    public override func becomeFirstResponder() -> Bool {
        action?()
        return super.becomeFirstResponder()
    }

}
