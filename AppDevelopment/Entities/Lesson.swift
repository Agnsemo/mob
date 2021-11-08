//
//  Lesson.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-13.
//

import Foundation

class Lesson: Decodable {
    var id: String
    var name: String
    var date: String
    var group: String
    var place: String
    var teacherName: String
    
    init(id: String, name: String, date: String, group: String, place: String, teacherName: String) {
        self.id = id
        self.name = name
        self.date = date
        self.group = group
        self.place = place
        self.teacherName = teacherName
    }
}
