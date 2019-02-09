//
//  AppDelegate.swift
//  BackgroundFetching
//
//  Created by Andrés Pizá Bückmann on 09/02/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Doing background fetch...")
        getQuestions { (result) in
            print("Finished background fetching")
            switch result {
            case .success(let numQuestions):
                UserDefaults.standard.set(true, forKey: UserDefaultsConstants.didBackgroundFetch)
                UserDefaults.standard.set(numQuestions, forKey: UserDefaultsConstants.numberOfQuestions)

                completionHandler(.newData)
            case .error:
                completionHandler(.noData)
            }
        }
    }
}
