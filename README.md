# ToolBox #
|Build|Coverage|
|:---:|:------:|
|[![Build Status](https://travis-ci.org/JediWed/ToolBox.svg?branch=master)](https://travis-ci.org/JediWed/ToolBox)| [![codecov](https://codecov.io/gh/JediWed/ToolBox/branch/master/graph/badge.svg)](https://codecov.io/gh/JediWed/ToolBox) |
### How to use 
#### TBQuickSelectionPresentationController
1. Create a class inherited from UITableViewController and implement UIViewControllerTransitioningDelegate
2. Add variables to the head of your class
```swift
public var afterQuickSelection: (() -> Void)?
private let blockView: UIView
```
3. Extend your *init*
```swift
self.blockView = UIView(frame: UIScreen.main.bounds)
```
4. Extend your *viewDidLoad*
```swift
self.blockView.backgroundColor = .black
self.blockView.alpha = 0.6
NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
```
5. Add a function *orientationDidChange*
```swift
private func orientationDidChange() {
    self.dismiss(animated: true, completion: nil)
}
```
6. Extend your *viewWillDisappear*
```swift
self.blockView.removeFromSuperview()
```
7. Implement *presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?*
```swift
 let controller = QuickSelectionPresentationController(presentedViewController: presented, presenting: presenting)
 controller.customHeight = rowCount * heightPerRow + spacingAtTheBottom
 return controller
``` 
8. Initialize your new ViewController
```swift
let viewController = MyNewQuickselectionViewController()
viewController.modalPresentationStyle = .custom
viewController.transitionDelegate = viewController
viewController.afterQuickSelection = Some Function
present(viewController, animated: true, completion: nil)
```
