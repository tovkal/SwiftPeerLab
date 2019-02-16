//
//  ViewController.swift
//  VideoStreaming
//
//  Created by Andrés Pizá Bückmann on 03/11/2018.
//  Copyright © 2018 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var container: UIView!

    @IBAction func didTapThumbnail(_ sender: UITapGestureRecognizer) {
        guard !thumbnail.isHidden else { return }
        thumbnail.isHidden = true
        container.isHidden = false
    }

    @IBAction func didDragPlayer(_ sender: UIPanGestureRecognizer) {
        guard sender.state != .began else { return }
        let translation = sender.translation(in: container)
        container.center = CGPoint(x: container.center.x + translation.x,
                                   y: container.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: container)
    }
}
