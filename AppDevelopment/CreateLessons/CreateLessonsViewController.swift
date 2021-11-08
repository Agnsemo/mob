//
//  CreateLessonsViewController.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-13.
//

import UIKit
import SwiftyUserDefaults

class CreateLessonsViewController: BaseViewController {

    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var lectureName: UITextField!
    @IBOutlet private var studentGroup: UITextField!
    @IBOutlet private var lecturePlace: UITextField!
    @IBOutlet private var lecturesID: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onConfirmButtonTapped(_ sender: Any) {
        guard let id = lecturesID.text, let name = lectureName.text, let group = studentGroup.text, let place = lecturePlace.text else {
            showAlert(with: "All fields should be filled")
            return
        }
        let teachersName: String = Defaults.teacher?.name ?? ""
        let teacherSurname: String = Defaults.teacher?.surname ?? ""
        let teachersFullName = teachersName + " " + teacherSurname
        LessonsMannager.shared.saveLesson(Lesson(id: id, name: name, date: datePicker.date.ISO8601Format(), group: group, place: place, teacherName: teachersFullName))
        
        showAlert(with: "Lecture added correctly")
        clearAllFealds()
    }
    
    private func clearAllFealds() {
        lectureName.text = nil
        lecturesID.text = nil
        studentGroup.text = nil
        lecturePlace.text = nil
    }
}
