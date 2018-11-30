//
//  UIColorTests.swift
//  ToolBoxTests
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import XCTest
@testable import ToolBox

class UIColorTests: XCTestCase {
    func testHexColors() {
        XCTAssertEqual(UIColor.red, UIColor.init(hex: 0xff0000))
        XCTAssertEqual(UIColor.red, UIColor.init(red: 255, green: 0, blue: 0))

        XCTAssertEqual(UIColor.green, UIColor.init(hex: 0x00ff00))
        XCTAssertEqual(UIColor.green, UIColor.init(red: 0, green: 255, blue: 0))

        XCTAssertEqual(UIColor.blue, UIColor.init(hex: 0x0000ff))
        XCTAssertEqual(UIColor.blue, UIColor.init(red: 0, green: 0, blue: 255))

        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor.init(hex: 0xffffff))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor.init(red: 255, green: 255, blue: 255))

        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 0, alpha: 1), UIColor.init(hex: 0x000000))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 0, alpha: 1), UIColor.init(red: 0, green: 0, blue: 0))
    }
}
