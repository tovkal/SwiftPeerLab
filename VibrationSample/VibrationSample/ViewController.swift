//
//  ViewController.swift
//  VibrationSample
//
//  Created by Andrés Pizá Bückmann on 11/05/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var label = UILabel()
    private var i = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let lastExecuted = UILabel()
        lastExecuted.text = "Last executed:"

        let button = UIButton()
        button.setTitle("Tap here!", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(lastExecuted)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

    @objc func tapped() {
        i += 1

        switch i {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            label.text = "NotificationFeedback type .error"

        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            label.text = "NotificationFeedback type .success"

        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            label.text = "NotificationFeedback type .warning"

        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            label.text = "ImpactFeedback type .light"

        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            label.text = "ImpactFeedback type .medium"

        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            label.text = "ImpactFeedback type .heavy"

        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            label.text = "SelectionFeedback"
            i = 0
        }
    }
}
