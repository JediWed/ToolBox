//
//  ProtocolTests.swift
//  ToolBoxTests
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import XCTest
@testable import ToolBox

class ProtocolTests: XCTestCase {

    let tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)
    let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func setUp() {
        super.setUp()
        tableView.tbRegister(TestTableViewCell.self)
        tableView.tbRegister(UITableViewCell.self)
        tableView.tbRegister(TestTableViewHeaderFooterView.self)
        tableView.tbRegister(UITableViewHeaderFooterView.self)
        tableView.dataSource = self
        tableView.delegate = self

        collectionView.tbRegister(TestCollectionViewCell.self)
        collectionView.tbRegister(UICollectionViewCell.self)
        collectionView.dataSource = self
    }

    func testIfCustomTableCellOrView() {
        XCTAssertTrue(tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) is TestTableViewCell,
                      "Cell is not kind of TestTableViewCell")
        XCTAssertTrue(tableView(tableView, viewForHeaderInSection: 0) is TestTableViewHeaderFooterView,
                      "HeaderView is not kind of TestTableViewHeaderFooterView")
        XCTAssertTrue(tableView(tableView, viewForFooterInSection: 0) is TestTableViewHeaderFooterView,
                      "FooterView is not kind of TestTableViewHeaderFooterView")
        XCTAssertTrue(collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) is TestCollectionViewCell,
                      "Cell is not kind of TestCollectionViewCell")
    }

    func testIfNotCustomTableCellOrView() {
        XCTAssertTrue(!(tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0)) is TestTableViewCell),
                      "Cell is not kind of UITableViewCell")
        XCTAssertTrue(!(tableView(tableView, viewForHeaderInSection: 1) is TestTableViewHeaderFooterView),
                      "HeaderView is not kind of UITableViewHeaderFooterView")
        XCTAssertTrue(!(tableView(tableView, viewForFooterInSection: 1) is TestTableViewHeaderFooterView),
                      "FooterView is not kind of UITableViewHeaderFooterView")
        XCTAssertTrue(!(collectionView(collectionView, cellForItemAt: IndexPath(item: 1, section: 0)) is TestCollectionViewCell),
                      "Cell is not kind of UICollectionViewCell")
    }

    func testReuseIdentifierType() {
        let cell = tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let headerView = tableView(tableView, viewForHeaderInSection: 0) as? TestTableViewHeaderFooterView
        let footerView = tableView(tableView, viewForFooterInSection: 0) as? TestTableViewHeaderFooterView
        let ccell = collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0))

        XCTAssertEqual(String(describing: TestTableViewCell.self), cell.reuseIdentifier)
        XCTAssertEqual(String(describing: TestTableViewHeaderFooterView.self), headerView?.reuseIdentifier)
        XCTAssertEqual(String(describing: TestTableViewHeaderFooterView.self), footerView?.reuseIdentifier)
        XCTAssertEqual(String(describing: TestCollectionViewCell.self), ccell.reuseIdentifier)
    }

    func testIfCustomAttributeWasSet() {
        let cell = tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TestTableViewCell
        XCTAssertNotNil(cell, "Cell couldn't be casted to TestTableViewCell")

        if let strongCell = cell {
            XCTAssertEqual(strongCell.customString, "Hello World")
        }

        let headerView = tableView(tableView, viewForHeaderInSection: 0) as? TestTableViewHeaderFooterView
        let footerView = tableView(tableView, viewForHeaderInSection: 0) as? TestTableViewHeaderFooterView
        XCTAssertNotNil(headerView, "View couldn't be casted to TestTableViewHeaderFooterView")
        XCTAssertNotNil(footerView, "View couldn't be casted to TestTableViewHeaderFooterView")

        if let hdv = headerView {
            XCTAssertEqual(hdv.customString, "Hello World")
        }

        if let ftv = footerView {
            XCTAssertEqual(ftv.customString, "Hello World")
        }

        let ccell = collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as? TestCollectionViewCell
        XCTAssertNotNil(ccell, "Cell couldn't be casted to TestCollectionViewCell")

        if let ccl = ccell {
            XCTAssertEqual(ccl.customString, "Hello World")
        }
    }
}

extension ProtocolTests: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.tbDequeueReusableCell(of: TestTableViewCell.self, for: indexPath)
            cell.customString = "Hello World"
            return cell
        default:
            return tableView.tbDequeueReusableCell(of: UITableViewCell.self, for: indexPath)
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return tableView.tbDequeueReusableHeaderFooterView(of: TestTableViewHeaderFooterView.self)
        default:
            return tableView.tbDequeueReusableHeaderFooterView(of: UITableViewHeaderFooterView.self)
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return tableView.tbDequeueReusableHeaderFooterView(of: TestTableViewHeaderFooterView.self)
        default:
            return tableView.tbDequeueReusableHeaderFooterView(of: UITableViewHeaderFooterView.self)
        }
    }
}

extension ProtocolTests: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            return collectionView.tbDequeueReusableCell(of: TestCollectionViewCell.self, for: indexPath)
        default:
            return collectionView.tbDequeueReusableCell(of: UICollectionViewCell.self, for: indexPath)
        }
    }
}
