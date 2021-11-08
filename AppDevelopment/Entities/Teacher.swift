//
//  Teacher.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import Foundation
import SwiftyUserDefaults

class Teacher: Codable, DefaultsSerializable {
    var name: String
    var surname: String
    var password: String
    var email: String
    
    init(name: String, surname: String, password: String, email: String) {
        self.name = name
        self.surname = surname
        self.password = password
        self.email = email
    }
}
