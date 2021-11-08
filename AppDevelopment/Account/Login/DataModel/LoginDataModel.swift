//
//  LoginDataModel.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import Foundation

class LoginDataModel {
    
    
    func isUserRegistered(email: String, onEnd: @escaping((Bool) -> Void)) {
        let isTeacher: Bool = TeachersManager.shared.teachers().contains(where: { $0.email == email })
        if isTeacher {
            if LoginTeachersManager.shared.teachers().contains(where: { $0.email == email }) {
                onEnd(true)
            } else {
                onEnd(false)
            }
        } else {
            if LoginStudentsManager.shared.students().contains(where: { $0.email == email }) {
                onEnd(true)
            } else {
                onEnd(false)
            }
        }
    }
}
