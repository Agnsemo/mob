//
//  UserTypeManager.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import Foundation
import SwiftyUserDefaults

class UserTypeManager {
    
    static let shared = UserTypeManager()
    
    var student: Student? {
        return Defaults.student
    }
    
    var teacher: Teacher? {
        return Defaults.teacher
    }
    
    func isUserStudent() -> Bool {
        return Defaults.student != nil
    }
    
    func isUserTecher() -> Bool {
        return Defaults.teacher != nil
    }
}
