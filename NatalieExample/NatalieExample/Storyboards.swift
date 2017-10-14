//
// Autogenerated by Natalie - Storyboard Generator
// by Marcin Krzyzanowski http://krzyzanowskim.com
//
import UIKit

// MARK: - Storyboards

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
        let instance = type.init()
        if let identifier = instance.storyboardIdentifier {
            return self.instantiateViewController(withIdentifier: identifier) as? T
        }
        return nil
    }

}

protocol Storyboard {
    static var storyboard: UIStoryboard { get }
    static var identifier: String { get }
}

struct Storyboards {

    struct Main: Storyboard {

        static let identifier = "Main"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> UINavigationController {
            return self.storyboard.instantiateInitialViewController() as! UINavigationController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }

        static func instantiateMainViewController() -> MainViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        }

        static func instantiateSecondViewController() -> ScreenTwoViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "secondViewController") as! ScreenTwoViewController
        }

        static func instantiateScreenOneViewController() -> ScreenOneViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "Screen One ViewController") as! ScreenOneViewController
        }

        static func instantiateSecondSubViewController() -> ScreenSubTwoViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "secondSubViewController") as! ScreenSubTwoViewController
        }
    }
}

// MARK: - ReusableKind
enum ReusableKind: String, CustomStringConvertible {
    case tableViewCell = "tableViewCell"
    case collectionViewCell = "collectionViewCell"

    var description: String { return self.rawValue }
}

// MARK: - SegueKind
enum SegueKind: String, CustomStringConvertible {
    case relationship = "relationship"
    case show = "show"
    case presentation = "presentation"
    case embed = "embed"
    case unwind = "unwind"
    case push = "push"
    case modal = "modal"
    case popover = "popover"
    case replace = "replace"
    case custom = "custom"

    var description: String { return self.rawValue }
}

// MARK: - IdentifiableProtocol

public protocol IdentifiableProtocol: Equatable {
    var storyboardIdentifier: String? { get }
}

// MARK: - SegueProtocol

public protocol SegueProtocol {
    var identifier: String? { get }
}

public func ==<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ~=<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ==<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
    return lhs.identifier == rhs
}

public func ~=<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
    return lhs.identifier == rhs
}

public func ==<T: SegueProtocol>(lhs: String, rhs: T) -> Bool {
    return lhs == rhs.identifier
}

public func ~=<T: SegueProtocol>(lhs: String, rhs: T) -> Bool {
    return lhs == rhs.identifier
}

// MARK: - ReusableViewProtocol
public protocol ReusableViewProtocol: IdentifiableProtocol {
    var viewType: UIView.Type? { get }
}

public func ==<T: ReusableViewProtocol, U: ReusableViewProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.storyboardIdentifier == rhs.storyboardIdentifier
}

// MARK: - Protocol Implementation
extension UIStoryboardSegue: SegueProtocol {
}

extension UICollectionReusableView: ReusableViewProtocol {
    public var viewType: UIView.Type? { return type(of: self) }
    public var storyboardIdentifier: String? { return self.reuseIdentifier }
}

extension UITableViewCell: ReusableViewProtocol {
    public var viewType: UIView.Type? { return type(of: self) }
    public var storyboardIdentifier: String? { return self.reuseIdentifier }
}

// MARK: - UIViewController extension
extension UIViewController {
    func perform<T: SegueProtocol>(segue: T, sender: Any?) {
        if let identifier = segue.identifier {
            performSegue(withIdentifier: identifier, sender: sender)
        }
    }

    func perform<T: SegueProtocol>(segue: T) {
        perform(segue: segue, sender: nil)
    }
}
// MARK: - UICollectionView

extension UICollectionView {

    func dequeue<T: ReusableViewProtocol>(reusable: T, for: IndexPath) -> UICollectionViewCell? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableCell(withReuseIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryViewOfKind<T: ReusableViewProtocol>(elementKind: String, withReusable reusable: T, for: IndexPath) -> UICollectionReusableView? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T, forSupplementaryViewOfKind elementKind: String) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        }
    }
}
// MARK: - UITableView

extension UITableView {

    func dequeue<T: ReusableViewProtocol>(reusable: T, for: IndexPath) -> UITableViewCell? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableCell(withIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableHeaderFooter<T: ReusableViewProtocol>(_ reusable: T) -> UITableViewHeaderFooterView? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableHeaderFooterView(withIdentifier: identifier)
        }
        return nil
    }

    func registerReusableHeaderFooter<T: ReusableViewProtocol>(_ reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
             register(type, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}

// MARK: - MainViewController
extension UIStoryboardSegue {
    func selection() -> MainViewController.Segue? {
        if let identifier = self.identifier {
            return MainViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}
protocol MainViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension MainViewController: MainViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: MainViewController {
    var storyboardIdentifier: String? { return "MainViewController" }
    static var storyboardIdentifier: String? { return "MainViewController" }
}
extension MainViewController {

    enum Segue: String, CustomStringConvertible, SegueProtocol {
        case screenOneSegueButton = "Screen One Segue Button"
        case screenOneSegue = "ScreenOneSegue"
        case screenTwoSegue = "ScreenTwoSegue"
        case sceneOneGestureRecognizerSegue = "SceneOneGestureRecognizerSegue"

        var kind: SegueKind? {
            switch self {
            case .screenOneSegueButton:
                return SegueKind(rawValue: "push")
            case .screenOneSegue:
                return SegueKind(rawValue: "push")
            case .screenTwoSegue:
                return SegueKind(rawValue: "push")
            case .sceneOneGestureRecognizerSegue:
                return SegueKind(rawValue: "push")
            }
        }

        var destination: UIViewController.Type? {
            switch self {
            case .screenOneSegueButton:
                return ScreenOneViewController.self
            case .screenOneSegue:
                return ScreenOneViewController.self
            case .screenTwoSegue:
                return ScreenTwoViewController.self
            case .sceneOneGestureRecognizerSegue:
                return ScreenOneViewController.self
            }
        }

        var identifier: String? { return self.rawValue }
        var description: String { return "\(self.rawValue)" }
    }

}

// MARK: - ScreenTwoViewController
protocol ScreenTwoViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension ScreenTwoViewController: ScreenTwoViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: ScreenTwoViewController {
    var storyboardIdentifier: String? { return "secondViewController" }
    static var storyboardIdentifier: String? { return "secondViewController" }
}
extension ScreenTwoViewController {

    enum Reusable: String, CustomStringConvertible, ReusableViewProtocol {
        case MyCell = "MyCell"

        var kind: ReusableKind? {
            switch self {
            case .MyCell:
                return ReusableKind(rawValue: "tableViewCell")
            }
        }

        var viewType: UIView.Type? {
            switch self {
            default:
                return nil
            }
        }

        var storyboardIdentifier: String? { return self.description }
        var description: String { return self.rawValue }
    }

}

// MARK: - ScreenOneViewController
protocol ScreenOneViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension ScreenOneViewController: ScreenOneViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: ScreenOneViewController {
    var storyboardIdentifier: String? { return "Screen One ViewController" }
    static var storyboardIdentifier: String? { return "Screen One ViewController" }
}

// MARK: - ScreenSubTwoViewController
protocol ScreenSubTwoViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension ScreenSubTwoViewController: ScreenSubTwoViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: ScreenSubTwoViewController {
    var storyboardIdentifier: String? { return "secondSubViewController" }
    static var storyboardIdentifier: String? { return "secondSubViewController" }
}
extension ScreenSubTwoViewController {

    enum Reusable: String, CustomStringConvertible, ReusableViewProtocol {
        case MyCellTwo = "MyCellTwo"

        var kind: ReusableKind? {
            switch self {
            case .MyCellTwo:
                return ReusableKind(rawValue: "tableViewCell")
            }
        }

        var viewType: UIView.Type? {
            switch self {
            default:
                return nil
            }
        }

        var storyboardIdentifier: String? { return self.description }
        var description: String { return self.rawValue }
    }

}

