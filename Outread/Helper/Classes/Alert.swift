//
//  Alert.swift
//  Outread
//
//  Created by AKASH BOGHANI on 28/06/24.
//

import UIKit

final class Alert {
    //MARK: - Properties
    static let shared = Alert()
    
    //MARK: - Life-Cycle
    private init() {}
    
    //MARK: - Functions
    func showAlert(title: String = Bundle.main.appName,
                   msg: String,
                   options: String...,
                   btnStyle: UIAlertAction.Style...,
                   completion: @escaping ((Int) -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alert.addAction(UIAlertAction(title: option,
                                          style: btnStyle[index],
                                          handler: { _ in
                                              completion(index)
                                          }))
        }
        var rootViewController = UIApplication.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        if let presentedVc = rootViewController?.presentedViewController {
            rootViewController = presentedVc
        }
        queue.async {
            rootViewController?.present(alert, animated: true, completion: nil)
        }
    }

    func showAlert(
        title: String = Bundle.main.appName,
        msg: String,
        buttonText: String? = "Ok"
    ) {
        showAlert(title: title, msg: msg, options: buttonText ?? "Ok", btnStyle: .default) { option in
            switch option {
            case 0: break
            default: break
            }
        }
    }
}
