//
//  String+Localized.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import Foundation

public extension String {
    func tbLocalized(forClass: AnyClass?) -> String {
        if let cls = forClass {
            return NSLocalizedString("\(String(describing: cls)).\(self)", comment: "")
        } else {
            return NSLocalizedString(self, comment: "")
        }
    }
}
