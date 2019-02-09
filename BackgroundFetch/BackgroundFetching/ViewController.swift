//
//  ViewController.swift
//  BackgroundFetching
//
//  Created by Andrés Pizá Bückmann on 09/02/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit

enum BackgroundFetchingError: Error {
    case noDataWTF
    case networkError
    case parsingError

    var description: String {
        switch self {
        case .noDataWTF:
            return "There's no data in dat response"
        case .networkError:
            return "ur connection wonky or smthng"
        case .parsingError:
            return "this shit in martian or what?"
        }
    }
}

enum Result<Value> {
    case success(Value)
    case error(Error)
}

struct UserDefaultsConstants {
    static let didBackgroundFetch = "did_background_fetch"
    static let numberOfQuestions = "num_questions"
}

class ViewController: UIViewController {

    @IBOutlet private var questionNumbersLabel: UILabel!

    @IBAction func didTap(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: UserDefaultsConstants.didBackgroundFetch) {
            setNumQuestions(UserDefaults.standard.integer(forKey: UserDefaultsConstants.numberOfQuestions))
        } else {
            getQuestions() { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let questionNumber):
                        self.setNumQuestions(questionNumber)
                    case .error(let error as BackgroundFetchingError):
                        let alert = UIAlertController(title: "wtf m8", message: error.description, preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok bye", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true)
                    default:
                        fatalError("All errors should be of type BackgroundFetchingError")
                    }
                }
            }
        }
    }

    @IBAction func didTapReset(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: UserDefaultsConstants.didBackgroundFetch)
        UserDefaults.standard.set(0, forKey: UserDefaultsConstants.numberOfQuestions)
        questionNumbersLabel.text = "none hahaha\n(try tapping the button you dumb monkey)"
        questionNumbersLabel.textColor = UIColor(red: 255/255, green: 120/255, blue: 224/255, alpha: 1)
    }

    private func setNumQuestions(_ numQuestions: Int) {
        questionNumbersLabel.text = "\(numQuestions) questions hahahah"

        questionNumbersLabel.textColor = UserDefaults.standard.bool(forKey: UserDefaultsConstants.didBackgroundFetch) ? UIColor.red : UIColor.blue
        UserDefaults.standard.set(false, forKey: UserDefaultsConstants.didBackgroundFetch)
    }
}

func getQuestions(completionHandler: @escaping (Result<Int>) -> Void) {
    let numQuestions = UserDefaults.standard.integer(forKey: UserDefaultsConstants.numberOfQuestions)

    var url = "https://polls.apiblueprint.org/questions"

    if numQuestions > 0 {
        url += "lalalathisurlwontwork"
    }

    print(url)

    URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
        if let error = error {
            completionHandler(.error(error))
        }

        guard let data = data else {
            completionHandler(.error(BackgroundFetchingError.noDataWTF))
            return
        }

        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
            completionHandler(.error(BackgroundFetchingError.networkError))
            return
        }

        do {
            let questions = try JSONDecoder().decode([Question].self, from: data)
            completionHandler(.success(questions.count))
        } catch {
            completionHandler(.error(BackgroundFetchingError.parsingError))
        }
    }
    .resume()
}

struct Question: Codable {
    let question: String
}
