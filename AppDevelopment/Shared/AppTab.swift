//
//  AppTab.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import UIKit

enum AppTab: Int, CaseIterable {
    case main
    case calendar
    case profile

    var title: String {
        switch self {
        case .main:
            return "Main"
        case .calendar:
            return "Calendar"
        case .profile:
            return "Profile"
        }
    }
    
    var rootViewController: UIViewController {
        switch self {
        case .main:
            return HomeViewController()
        case .calendar:
            if UserTypeManager.shared.isUserTecher() {
                return CreateLessonsViewController()
            } else {
                return UIViewController()
            }
        case .profile:
            return ProfileViewController()
        }
    }
}

