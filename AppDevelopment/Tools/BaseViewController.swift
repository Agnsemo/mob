//
//  BaseViewController.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Declarations
    var keyboardWillShowNotification: NSObjectProtocol?
    var keyboardWillHideNotification: NSObjectProtocol?
    
    func presentController(withRootViewController rootViewController: UIViewController) {
        let controller = rootViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    func showAlert(with title: String) {
        let alertVC = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
}

