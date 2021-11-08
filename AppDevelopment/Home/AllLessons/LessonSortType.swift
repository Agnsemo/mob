//
//  LessonSortType.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-11-07.
//

import Foundation

enum LessonSortType: CaseIterable {
    
case name
case date
case userRegisterToClasses
case none
    
    static var userList: [LessonSortType] {
           return [.name, .date, .none]
       }
    
    var actionTitle: String {
        switch self {
        case .name:
            return "Name"
        case .date:
            return "Date"
        case .userRegisterToClasses:
            return "Users registered to classes"
        case .none:
            return "None"
        }
    }
    
    var isUserRegisterToClasses: Bool {
        return self == .userRegisterToClasses
    }
}
