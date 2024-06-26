//
//  Ext+UIViewController.swift
//  Outread
//
//  Created by AKASH BOGHANI on 26/05/24.
//

import UIKit
import IHProgressHUD

// MARK: - Hide/Show Huds
extension UIViewController {
    func showHUD(progressLabel: String = "Loading...", hudColor: UIColor = .white) {
        queue.async {
            IHProgressHUD.set(backgroundColor: .clear)
            IHProgressHUD.setHapticsEnabled(hapticsEnabled: true)
            IHProgressHUD.set(containerView: UIApplication.keyWindow?.rootViewController?.view)
            IHProgressHUD.set(defaultAnimationType: .flat)
            IHProgressHUD.set(defaultMaskType: .clear)
            IHProgressHUD.set(foregroundColor: hudColor)
            IHProgressHUD.set(ringThickness: 4)
            IHProgressHUD.set(font: .boldSystemFont(ofSize: 17))
            IHProgressHUD.set(ringRadius: 20)
            IHProgressHUD.show(withStatus: progressLabel)
            UIApplication.keyWindow?.rootViewController?.view.isUserInteractionEnabled = false
        }
    }

    func hideHUD() {
        queue.async {
            IHProgressHUD.dismissWithCompletion {
                UIApplication.keyWindow?.rootViewController?.view.isUserInteractionEnabled = true
            }
        }
    }
}

// MARK: - Show Alerts
extension UIViewController {
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

    func showAlert(title: String = Bundle.main.appName, msg: String, buttonText: String? = "OK") {
        showAlert(title: title,
                  msg: msg,
                  options: buttonText ?? "OK",
                  btnStyle: .default) { option in
            switch option {
            case 0: break
            default: break
            }
        }
    }
}
