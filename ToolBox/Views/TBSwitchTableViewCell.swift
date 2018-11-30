//
//  TBSwitchTableViewCell.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import UIKit

public class TBSwitchTableViewCell: UITableViewCell {

    public let `switch`: UISwitch = {
        let swi = UISwitch()
        swi.setOn(false, animated: true)
        return swi
    }()

    public var isEnabled: Bool = true {
        didSet {
            isUserInteractionEnabled = isEnabled
            updateTextColor()
        }
    }

    public var onSwitch: ((Bool) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true

        `switch`.tbAddActionForControlEvents(.valueChanged) { [unowned self] (swi: UISwitch) in
            self.onSwitch?(swi.isOn)
        }
        // Let the cell create the text label
        _ = textLabel
        self.accessoryView = `switch`

    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func becomeFirstResponder() -> Bool {
        `switch`.setOn(!`switch`.isOn, animated: true)
        self.onSwitch?(`switch`.isOn)
        return super.becomeFirstResponder()
    }

    private func updateTextColor() {
        textLabel?.textColor = isEnabled ? .black : UIColor.black.withAlphaComponent(0.5)
    }
}
