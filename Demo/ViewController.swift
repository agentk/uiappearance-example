import UIKit

extension UINavigationController {
    @objc func dismissModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class ActionViewController: UIViewController {
    func alternateNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigationController: UINavigationController
        if self.navigationController is DarkNavigationController {
            navigationController = UINavigationController()
        } else {
            navigationController = DarkNavigationController()
        }
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: navigationController, action: #selector(UINavigationController.dismissModal))
        navigationController.viewControllers = [rootViewController]
        return navigationController
    }

    @IBAction func action(_ sender: UIButton) {
        let primary = sender.titleLabel?.text?.contains("Primary") ?? false
        let usePresent = sender.titleLabel?.text?.contains("Present") ?? false
        let viewController = ViewController.instantiate(identifier: primary ? "One" : "Two")
        if usePresent {
            let navigationController = alternateNavigationController(rootViewController: viewController)
            present(navigationController, animated: true, completion: nil)
        } else {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

class ViewController: UIViewController {

    static func instantiate(identifier: String) -> ViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as! ViewController
    }
}
