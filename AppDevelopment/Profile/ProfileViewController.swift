//
//  ProfileViewController.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-13.
//

import UIKit
import SwiftyUserDefaults
import Photos

class ProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var surnameLabel: UILabel!
    @IBOutlet private var groupLabel: UILabel!
    @IBOutlet private var groupStackView: UIStackView!
    @IBOutlet private var profilePicture: UIImageView!
    
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        setupUserData()
        addImageButton()
    }
    
    @IBAction func onLogoutButtonTapped(_ sender: Any) {
        if UserTypeManager.shared.isUserStudent() {
            Defaults.student = nil
        }
        
        if UserTypeManager.shared.isUserTecher() {
            Defaults.teacher = nil
        }
        self.presentController(withRootViewController: UINavigationController(rootViewController: LoginViewController()))
    }
    
    private func setupUserData() {
        if let student = UserTypeManager.shared.student {
            emailLabel.text = student.email
            nameLabel.text = student.name
            surnameLabel.text = student.surname
            groupLabel.text = student.group
            groupStackView.isHidden = false
        }
        
        if let teacher = UserTypeManager.shared.teacher {
            emailLabel.text = teacher.email
            nameLabel.text = teacher.name
            surnameLabel.text = teacher.surname
            groupStackView.isHidden = true
        }
    }
    
    func addImageButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.add,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(addImage))
    }
    
    @objc func addImage() {
        openGalleryOrCamera()
    }
    
    private func openGalleryOrCamera() {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let camera = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                
                let status = AVCaptureDevice.authorizationStatus(for: .video)
                switch status {
                case .notDetermined:
                    AVCaptureDevice.requestAccess(for: .video) { response in
                        if response {
                            DispatchQueue.main.async {
                                self?.openCamera()
                            }
                        } else {
                            return
                        }
                    }
                case .restricted, .denied:
                    self?.openSettingsAlert(title: "Enable camera permissions in settings")
                case .authorized:
                    self?.openCamera()
                @unknown default:
                    return
                }
            }
            
            alertVC.addAction(camera)
        }
        
        let gallery = UIAlertAction(title: "Gallery", style: .default) { [weak self] _ in
            
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized, .limited:
                self?.openGallery()
            case .denied, .restricted :
                self?.openSettingsAlert(title: "Enable photo permissions in settings")
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { status in
                    switch status {
                    case .authorized, .limited:
                        DispatchQueue.main.async {
                            self?.openGallery()
                        }
                    case .denied, .restricted:
                        return
                    case .notDetermined:
                        return
                    @unknown default:
                        return
                    }
                }
            @unknown default:
                return
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertVC.addAction(gallery)
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    private func openSettingsAlert(title: String) {
        let alertVC = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: title, style: .cancel) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    private func openCamera() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    private func openGallery() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            profilePicture.image = image
            
        } else if let image = info[.originalImage] as? UIImage {
            profilePicture.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
