//
//  EditLessonsDataModel.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-18.
//

import Foundation

class EditLessonsDataModel {
    
    var lecturesID: String
    var date: String
    var lectureName: String
    var studentsGroup: String
    var place: String
    
    init(lecturesID: String, date: String, lectureName: String, studentsGroup: String, place: String) {
        self.lecturesID = lecturesID
        self.date = date
        self.lectureName = lectureName
        self.studentsGroup = studentsGroup
        self.place = place
    }
}
