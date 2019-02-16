//
//  Created by Andrés Pizá Bückmann on 26/06/2018.
//  Copyright © 2018 Atabix. All rights reserved.
//

import UIKit

public extension UIViewController {

    // MARK: Container VCs methods

    func addContentController(_ child: UIViewController, to stackView: UIStackView, inFirstPosition: Bool = false) {
        addChild(child)

        if inFirstPosition {
            stackView.insertArrangedSubview(child.view, at: 0)
        } else {
            stackView.addArrangedSubview(child.view)
        }

        child.didMove(toParent: self)
    }

    func addContentController(_ child: UIViewController, to view: UIView, addConstraints: Bool = true) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)

        if addConstraints {
            let top = NSLayoutConstraint(item: child.view, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
            let left = NSLayoutConstraint(item: child.view, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint(item: child.view, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            let right = NSLayoutConstraint(item: child.view, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)

            child.view.addConstraints([top, left, bottom, right])
        }
    }

    func removeContentController(_ child: UIViewController, from stackView: UIStackView) {
        child.willMove(toParent: nil)
        stackView.removeArrangedSubview(child.view)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }

    func removeContentController(_ child: UIViewController, from view: UIView) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
