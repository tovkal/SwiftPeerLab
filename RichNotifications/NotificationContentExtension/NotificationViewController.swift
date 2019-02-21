//
//  NotificationViewController.swift
//  NotificationContentExtension
//
//  Created by Plamen Andreev on 16/02/2019.
//  Copyright © 2019 DMI Inc. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import AVKit

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
      let moviePath = Bundle.main.url(forResource: "SampleVideo_1280x720_1mb", withExtension: "mp4")!
      let player = AVPlayer(url: moviePath)
      let playerViewController = AVPlayerViewController()
      playerViewController.player = player
      player.play()

      addChild(playerViewController)
      view.addSubview(playerViewController.view)
      playerViewController.didMove(toParent: self)

      playerViewController.view.frame = view.bounds
    }
}
