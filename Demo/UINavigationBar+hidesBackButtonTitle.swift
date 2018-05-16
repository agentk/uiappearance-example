import UIKit

class StyledNavigationDelegate: NSObject, UINavigationControllerDelegate {
    static let shared = StyledNavigationDelegate()

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard viewController.navigationItem.backBarButtonItem == nil else { return }
        hideBackButton(viewController)
    }

    func hideBackButton(_ viewController: UIViewController) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension UINavigationBar {
    @objc dynamic var hidesBackButtonTitle: Bool {
        get {
            // We don't use the get value here but the getter needs to be defined. As an example we could
            // just check the type of delegate set on the navigation controller.
            return (parentViewController as? UINavigationController)?.delegate === StyledNavigationDelegate.shared
        }
        set {
            guard
                let navigationController = parentViewController as? UINavigationController,
                navigationController.delegate == nil
            else {
                return
            }
            navigationController.delegate = StyledNavigationDelegate.shared

            // Call the delegate initially to catch the first pushed view controller.
            for viewController in navigationController.viewControllers {
                StyledNavigationDelegate.shared.hideBackButton(viewController)
            }
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
