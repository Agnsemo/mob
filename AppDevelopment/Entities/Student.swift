//
//  Student.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import Foundation
import SwiftyUserDefaults

class Student: Codable, DefaultsSerializable {
    var name: String
    var surname: String
    var password: String
    var email: String
    var group: String
    
    init(name: String, surname: String, password: String, email: String, group: String) {
        self.name = name
        self.surname = surname
        self.password = password
        self.email = email
        self.group = group
    }
}
