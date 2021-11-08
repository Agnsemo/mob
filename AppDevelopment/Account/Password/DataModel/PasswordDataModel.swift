//
//  PasswordDataModel.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-13.
//

import Foundation
import SwiftyUserDefaults

class PasswordDataModel {
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    func loginUser(password: String, onSuccess: @escaping(() -> Void), onFail: @escaping(() -> Void)) {
        let isTeacher: Bool = TeachersManager.shared.teachers().contains(where: { $0.email == email })
        if isTeacher {
            if LoginTeachersManager.shared.teachers().contains(where: { $0.email == email && $0.password == password }) {
                Defaults.teacher = LoginTeachersManager.shared.teachers().first(where: { $0.email == email })
                onSuccess()
            } else {
                onFail()
            }
        } else {
            if LoginStudentsManager.shared.students().contains(where: { $0.email == email && $0.password == password }) {
                Defaults.student = LoginStudentsManager.shared.students().first(where: { $0.email == email })
                onSuccess()
            } else {
                onFail()
            }
        }
    }
}
