//
//  PasswordViewController.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import UIKit

class PasswordViewController: BaseViewController {

    @IBOutlet private var passwordLabel: UITextField!
    @IBOutlet private var confirmButton: UIButton!
    
    var dataModel: PasswordDataModel!
    
    // MARK: - Methods
    init(with email: String) {
        super.init(nibName: nil, bundle: nil)
        
        dataModel = PasswordDataModel(email: email)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Log in"
    }
    
    @IBAction func onConfirmButtonTapped(_ sender: Any) {
        guard let password = passwordLabel.text else {
            showAlert(with: "All fields should be filled")
            return
        }
        dataModel.loginUser(password: password, onSuccess: {
            self.presentController(withRootViewController: RootTabBarController())
        }, onFail: {
            print("FAILED")
        })
    }
}
