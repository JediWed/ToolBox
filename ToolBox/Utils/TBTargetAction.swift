//
//  TBTargetAction.swift
//  ToolBox
//
//  Created by Ediz Turcan on 30.11.18.
//  Copyright © 2018 Ediz Turcan. All rights reserved.
//

import UIKit

private protocol TBTargetActionType: class {
    var actionSelector: Selector { get }
}

public class TBTargetAction<T: NSObjectProtocol>: NSObject, TBTargetActionType {
    fileprivate let actionSelector: Selector = #selector(TBTargetAction<T>.action(_:))
    fileprivate let actionBlock: (T) -> Void
    fileprivate weak var target: T?
    @objc
    fileprivate func action(_ sender: NSObjectProtocol) {
        guard let sender = sender as? T else { return }
        actionBlock(sender)
    }
    init(target: T? = nil, actionBlock: @escaping (T) -> Void) {
        self.actionBlock = actionBlock
    }
}

public extension TBTargetAction where T: UIControl {
    func tbRemove() {
        if let target = target {
            target.tbRemoveAction(self)
        }
    }
}

private class TBTargetActionHolder {
    fileprivate static var targetActionHolder = "targetActionList"
    fileprivate var targetActions: [TBTargetActionType] = []
}

private extension NSObjectProtocol {
    @nonobjc
    var targetActionHolder: TBTargetActionHolder {
        get {
            let asc = objc_getAssociatedObject(self,
                                               &TBTargetActionHolder.targetActionHolder)
            if let holder = asc as? TBTargetActionHolder {
                return holder
            } else {
                let holder = TBTargetActionHolder()
                self.targetActionHolder = holder
                return holder
            }
        }
        set {
            objc_setAssociatedObject(self,
                                     &TBTargetActionHolder.targetActionHolder,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

    }
}

public extension UIControl {

    @discardableResult
    func tbAddActionForControlEvents<T: UIControl>(_ controlEvents: UIControl.Event,
                                                   action: @escaping (T) -> Void) -> TBTargetAction<T> {
        let action = TBTargetAction(target: self as? T, actionBlock: action)
        addTarget(action, action: action.actionSelector, for: controlEvents)
        targetActionHolder.targetActions.append(action)
        return action
    }

    func tbRemoveAllActions() {
        removeTarget(nil, action: nil, for: .allEvents)
        targetActionHolder.targetActions = []
    }

    func tbRemoveAction<T>(_ action: TBTargetAction<T>) {
        if let index = targetActionHolder.targetActions.index(where: {$0 === action}) {
            removeTarget(action, action: action.actionSelector, for: UIControl.Event.allEvents)
            targetActionHolder.targetActions.remove(at: index)

        }
    }

}

public extension UIButton {
    @discardableResult
    func tbAddAction<T: UIControl>(_ action: @escaping (T) -> Void) -> TBTargetAction<T> {
        return self.tbAddActionForControlEvents(.touchUpInside, action: action)
    }
}

public extension UISwitch {
    @discardableResult
    func tbAddAction<T: UIControl>(_ action: @escaping (T) -> Void) -> TBTargetAction<T> {
        return self.tbAddActionForControlEvents(.valueChanged, action: action)
    }
}
