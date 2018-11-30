//
//  CGFloatTests.swift
//  ToolBoxTests
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import XCTest
@testable import ToolBox

class CGFloatTests: XCTestCase {
    func testIfFitToFourPattern() {
        XCTAssertEqual(CGFloat.tbSpacingVerySmall.truncatingRemainder(dividingBy: 4), 0)
        XCTAssertEqual(CGFloat.tbSpacingSmall.truncatingRemainder(dividingBy: 4), 0)
        XCTAssertEqual(CGFloat.tbSpacingMiddle.truncatingRemainder(dividingBy: 4), 0)
        XCTAssertEqual(CGFloat.tbSpacingLarge.truncatingRemainder(dividingBy: 4), 0)
        XCTAssertEqual(CGFloat.tbSpacingCellHorizontalPadding.truncatingRemainder(dividingBy: 4), 0)
        XCTAssertEqual(CGFloat.tbStepperTextFieldWidth.truncatingRemainder(dividingBy: 4), 0)
        XCTAssertEqual(CGFloat.tbQuickSelectionMaxWidth.truncatingRemainder(dividingBy: 4), 0)
    }
}
