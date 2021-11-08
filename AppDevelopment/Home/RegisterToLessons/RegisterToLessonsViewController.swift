//
//  RegisterToLessonsViewController.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-25.
//

import UIKit
import SwiftyUserDefaults

class RegisterToLessonsViewController: BaseViewController {

    @IBOutlet var name: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var teachersStudentsname: UILabel!
    @IBOutlet var place: UILabel!
    
    var dataModel: RegisterToLessonsDataModel!
    
    init(lesson: Lesson) {
        super.init(nibName: nil, bundle: nil)
        
        dataModel = RegisterToLessonsDataModel(lesson: lesson)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register to the lecture"
        setupContent()
    }
    
    private func setupContent() {
        name.text = dataModel.lesson.name
        date.text = dataModel.lesson.date
        teachersStudentsname.text = dataModel.lesson.teacherName
        place.text = dataModel.lesson.place
    }
    
    @IBAction func onRegisterUserTapped(_ sender: Any) {
        let lesson = Lesson(id: dataModel.lesson.id, name: dataModel.lesson.name,
                            date: dataModel.lesson.date, group: dataModel.lesson.group,
                            place: dataModel.lesson.place, teacherName: dataModel.lesson.teacherName)
        
        RegisterToLessonsManager.shared.saveLesson(lesson)
        navigationController?.popToRootViewController(animated: true)
    }
}
