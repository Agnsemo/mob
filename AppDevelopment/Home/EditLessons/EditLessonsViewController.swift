//
//  EditLessonsViewController.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-18.
//

import UIKit
import SwiftyUserDefaults

class EditLessonsViewController: BaseViewController {
    
    @IBOutlet private var lecturesID: UILabel!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var lectureName: UITextField!
    @IBOutlet private var studentsGroup: UITextField!
    @IBOutlet private var place: UITextField!
    
    var dataModel: EditLessonsDataModel!
    
    init(lecturesID: String, date: String, lectureName: String, studentsGroup: String, place: String) {
        super.init(nibName: nil, bundle: nil)
        
        dataModel = EditLessonsDataModel(lecturesID: lecturesID, date: date, lectureName: lectureName, studentsGroup: studentsGroup, place: place)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFields()
    }
    
    private func setupFields() { //ISO8601FormatStyle
        datePicker.date = convertStringDate(stringDate: dataModel.date) ?? Date()
        lectureName.text = dataModel.lectureName
        studentsGroup.text = dataModel.studentsGroup
        place.text = dataModel.place
        lecturesID.text = dataModel.lecturesID
    }
    
    @IBAction func onConfirmButtonTapped(_ sender: Any) {
        guard let id = lecturesID.text, let name = lectureName.text, let group = studentsGroup.text, let place = place.text else {
            showAlert(with: "All fields should be filled")
            return
        }
        let teachersName: String = Defaults.teacher?.name ?? ""
        let teacherSurname: String = Defaults.teacher?.surname ?? ""
        let teachersFullName = teachersName + " " + teacherSurname
        
        LessonsMannager.shared.editLessonByID(lesson: Lesson(id: id, name: name, date: datePicker.date.ISO8601Format(), group: group, place: place, teacherName: teachersFullName))
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Helpers
    private func convertStringDate(stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: stringDate)
        guard let date = date else {
            print("Could not convert date")
            return nil
        }
        return date
    }
}
