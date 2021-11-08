//
//  Defaults.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-14.
//

import UIKit
import SwiftyUserDefaults

extension DefaultsKeys {
    var student: DefaultsKey<Student?> { .init("student") }
    var teacher: DefaultsKey<Teacher?> { .init("teacher") }
}
