//
//  ViewController.swift
//  RichBitchNotifications
//
//  Created by Plamen Andreev on 16/02/2019.
//  Copyright © 2019 DMI Inc. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
      print("GRANTED!")
    }

    let content = UNMutableNotificationContent()
    content.title = "Title"
    content.body = "Body"
    content.categoryIdentifier = "myNotificationCategory"

    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    dateComponents.second = Calendar.current.component(.second, from: Date(timeIntervalSinceNow: 5))
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { (error) in
      print(error)
    }
  }
}

