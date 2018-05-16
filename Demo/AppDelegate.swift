import UIKit

// MARK: - Style-able subclasses

class DarkNavigationController: UINavigationController {}
class MixedNavigationController: UINavigationController {}

class BackgroundView: UIView {}

class TitleLabel: UILabel {}
class SubtitleLabel: UILabel {}

class PrimaryButton: UIButton {}
class SecondaryButton: UIButton {}

// MARK: - Colour constants

extension UIColor {
    static let demoDark = UIColor(red: 0.255, green: 0.459, blue: 0.019, alpha: 1)
    static let demoDarkGray = UIColor(red: 0.313, green: 0.317, blue: 0.298, alpha: 1)
    static let demoLight = UIColor(red: 0.494, green: 0.826, blue: 0.129, alpha: 1)
    static let demoLightGray = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    static let transparent = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
}

// MARK: - AppDelegate Based Architecture

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Defaults

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().hidesBackButtonTitle = true

        UILabel.appearance().adjustsFontForContentSizeCategory = true
        UIButton.appearance().cornerRadius = 3

        // Light appearance

        setupAppearance(whenContainedInInstancesOf: [UINavigationController.self]) {
            navBar, backgroundView, primaryButton, secondaryButton, titleLabel, subtitleLabel in

            navBar.barStyle = .default
            navBar.barTintColor = .demoLight
            navBar.tintColor = .black

            backgroundView.backgroundColor = .demoLightGray

            titleLabel.textColor = .black
            subtitleLabel.textColor = .black

            primaryButton.backgroundColor = .demoDarkGray
            primaryButton.borderWidth = 0
            primaryButton.tintColor = .white

            secondaryButton.backgroundColor = .transparent
            secondaryButton.borderColor = .demoDarkGray
            secondaryButton.borderWidth = 1
            secondaryButton.tintColor = .demoDarkGray
        }

        // Dark appearance

        setupAppearance(whenContainedInInstancesOf: [DarkNavigationController.self]) {
            navBar, backgroundView, primaryButton, secondaryButton, titleLabel, subtitleLabel in

            navBar.barStyle = .black
            navBar.barTintColor = .demoDarkGray
            navBar.tintColor = .white
            navBar.shadowImage = UIImage()

            backgroundView.backgroundColor = .demoDarkGray
            titleLabel.textColor = .demoLight
            subtitleLabel.textColor = .demoLightGray

            primaryButton.backgroundColor = .demoLight
            primaryButton.tintColor = .black

            secondaryButton.borderColor = .demoLightGray
            secondaryButton.tintColor = .white
        }

        // Mixed appearance

        setupAppearance(whenContainedInInstancesOf: [MixedNavigationController.self]) {
            navBar, backgroundView, primaryButton, secondaryButton, titleLabel, subtitleLabel in

            navBar.barStyle = .black
            navBar.barTintColor = .demoDark
            navBar.tintColor = .lightGray

            backgroundView.backgroundColor = .demoDarkGray

            titleLabel.textColor = .white
            subtitleLabel.textColor = .lightGray

            primaryButton.backgroundColor = .transparent
            primaryButton.borderColor = .demoLight
            primaryButton.borderWidth = 1
            primaryButton.tintColor = .demoLight

            secondaryButton.borderColor = .demoLightGray
            secondaryButton.tintColor = .demoLightGray

        }

        return true
    }

    func setupAppearance(whenContainedInInstancesOf containerTypes: [UIAppearanceContainer.Type], _ fn: (
        _ navigationBar: UINavigationBar,
        _ backgroundView: UIView,
        _ primaryButton: PrimaryButton,
        _ secondaryButton: SecondaryButton,
        _ titleLabel: TitleLabel,
        _ subtitleLabel: SubtitleLabel) -> Void) {
        fn(
            UINavigationBar.appearance(whenContainedInInstancesOf: containerTypes),
            BackgroundView.appearance(whenContainedInInstancesOf: containerTypes),
            PrimaryButton.appearance(whenContainedInInstancesOf: containerTypes),
            SecondaryButton.appearance(whenContainedInInstancesOf: containerTypes),
            TitleLabel.appearance(whenContainedInInstancesOf: containerTypes),
            SubtitleLabel.appearance(whenContainedInInstancesOf: containerTypes))
    }
}
