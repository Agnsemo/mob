//
//  RegisterDataModel.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-13.
//

import Foundation
import SwiftyUserDefaults

class RegisterDataModel {
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    func registerUser(name: String, surname: String, group: String, password: String, onSuccess: @escaping(() -> Void)) {
        let isTeacher: Bool = TeachersManager.shared.teachers().contains(where: { $0.email == email })
        if isTeacher {
            let teacher = Teacher(name: name, surname: surname, password: password, email: email)
            LoginTeachersManager.shared.saveTeacher(teacher)
            Defaults.teacher = teacher
            onSuccess()
        } else {
            let student = Student(name: name, surname: surname, password: password, email: email, group: group)
            LoginStudentsManager.shared.saveStudent(student)
            Defaults.student = student
            onSuccess()
        }
    }
    
    func isTeacher() -> Bool {
        return TeachersManager.shared.teachers().contains(where: { $0.email == email })
    }
}

