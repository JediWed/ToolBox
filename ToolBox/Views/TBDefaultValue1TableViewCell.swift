//
//  TBDefaultValue1TableViewCell.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import UIKit

public class TBDefaultValue1TableViewCell: UITableViewCell {

    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.allowsDefaultTighteningForTruncation = false
        label.accessibilityIdentifier = "tbdefaultvalue1tableviewcell_titlelabel"
        return label
    }()

    public let detailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "tbdefaultvalue1tableviewcell_detaillabel"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textLabel?.isHidden = true
        detailTextLabel?.isHidden = true

        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)

        addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal,
                               toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView,
                               attribute: .leading, multiplier: 1, constant: .tbSpacingCellHorizontalPadding),
            NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal,
                               toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal,
                               toItem: contentView, attribute: .trailing, multiplier: 0.5, constant: 0),
            NSLayoutConstraint(item: detailLabel, attribute: .top, relatedBy: .equal,
                               toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: detailLabel, attribute: .leading, relatedBy: .equal,
                               toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: .tbSpacingSmall),
            NSLayoutConstraint(item: detailLabel, attribute: .trailing, relatedBy: .equal,
                               toItem: contentView, attribute: .trailing, multiplier: 1, constant: -.tbSpacingCellHorizontalPadding),
            NSLayoutConstraint(item: detailLabel, attribute: .bottom, relatedBy: .equal,
                               toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
            ])
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("Do not use this initializer")
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
