//
//  HomeTableViewCell.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-13.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet private var name: UILabel!
    @IBOutlet private var date: UILabel!
    @IBOutlet private var teacherName: UILabel!
    @IBOutlet private var studentsGroup: UILabel!
    
    func setup(name: String, date: String, teacherName: String, studentsGroup: String) {
        self.name.text = name
        self.date.text = date
        self.teacherName.text = teacherName
        self.studentsGroup.text = studentsGroup
    }
}
