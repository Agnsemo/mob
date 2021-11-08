//
//  LoginViewController.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet private var emailTextField: UITextField!
    
    var dataModel: LoginDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataModel = LoginDataModel()
        title = "Sign up / Log in"
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        guard let email = emailTextField.text else {
            showAlert(with: "All fields should be filled")
            return
        }
        dataModel.isUserRegistered(email: email, onEnd: { isUserRegistered in
            isUserRegistered ? self.openPasswordView() : self.openRegisterView()
        })
    }
    
    // MARK: - Private
    private func openPasswordView() {
        let viewController = PasswordViewController(with: emailTextField.text ?? "")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func openRegisterView() {
        let viewController = RegisterViewController(with: emailTextField.text ?? "")
        navigationController?.pushViewController(viewController, animated: true)
    }
}
