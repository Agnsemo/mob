//
//  RegisterViewController.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var surnameField: UITextField!
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var groupField: UITextField!
    @IBOutlet private var confirmButton: UIButton!
    
    var dataModel: RegisterDataModel!
    
    // MARK: - Methods
    init(with email: String) {
        super.init(nibName: nil, bundle: nil)
        
        dataModel = RegisterDataModel(email: email)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign up"
        setupEmail()
        setupGroup()
    }
    
    func setupEmail() {
        emailLabel.text = dataModel.email
    }
    
    func setupGroup() {
        groupField.isHidden = dataModel.isTeacher()
    }
    
    @IBAction func onConfirmButtonTapped(_ sender: Any) {
        guard let name = nameField.text, let surname = surnameField.text, let password = passwordTextField.text else {
            showAlert(with: "All fields should be filled")
            return
        }
        dataModel.registerUser(name: name, surname: surname, group: groupField.text ?? "", password: password, onSuccess: {
            self.presentController(withRootViewController: RootTabBarController())
        })
    }
}
