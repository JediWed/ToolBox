//
//  ReusableIdentifierProtocol.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import UIKit

protocol TBReuseIdentifierType {
    static var reuseIdentifier: String { get }
}

extension TBReuseIdentifierType {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: TBReuseIdentifierType {}

extension UICollectionView {

    func tbRegister<T>(_ cellClass: T.Type) where T: UICollectionViewCell {
        register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func tbDequeueReusableSupplementaryView<T: TBReuseIdentifierType>(ofType type: T.Type,
                                                                      kind elementKind: String,
                                                                      for indexPath: IndexPath) -> T {
        let view = dequeueReusableSupplementaryView(ofKind: elementKind,
                                                    withReuseIdentifier: T.reuseIdentifier,
                                                    for: indexPath)
        guard let typedView = view as? T else {
            fatalError("View of wrong type has been registered. Expected: \(T.self), Actual: \(Swift.type(of: view))")
        }
        return typedView
    }

    func tbDequeueReusableCell<T>(of type: T.Type, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath)
        guard let typedCell = cell as? T else {
            fatalError("Cell of wrong type has been registered. Expected: \(T.self), Actual: \(Swift.type(of: cell))")
        }
        return typedCell
    }
}

extension UITableViewCell: TBReuseIdentifierType {}
extension UITableViewHeaderFooterView: TBReuseIdentifierType {}

public extension UITableView {

    func tbRegister<T>(_ cellClass: T.Type) where T: UITableViewCell {
        register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func tbRegister<T>(_ headerFooterViewClass: T.Type) where T: UITableViewHeaderFooterView {
        register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func tbDequeueReusableCell<T>(of type: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)
        guard let typedCell = cell as? T else {
            fatalError("Cell of wrong type has been registered. Expected: \(T.self), Actual: \(Swift.type(of: cell))")
        }
        return typedCell
    }

    func tbDequeueReusableHeaderFooterView<T>(of type: T.Type) -> T where T: UITableViewHeaderFooterView {
        let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier)
        guard let typedView = view as? T else {
            fatalError("View of wrong type has been registered. Expected: \(T.self), Actual: \(Swift.type(of: view))")
        }
        return typedView
    }

}
