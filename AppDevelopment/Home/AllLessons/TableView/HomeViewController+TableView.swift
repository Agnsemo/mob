//
//  HomeViewController+TableView.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-13.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataModel.lessonsByUserType().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lesson = dataModel.lessonsByUserType()[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withType: HomeTableViewCell.self) else {
            print("WARNING! Unable to dequeue HomeTableViewCell")
            return UITableViewCell()
        }
        cell.setup(name: lesson.name, date: lesson.date, teacherName: lesson.teacherName, studentsGroup: lesson.place)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if UserTypeManager.shared.isUserTecher() {
            let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
                let lesson = self.dataModel.lessonsByUserType()[indexPath.row]
                self.showEditView(lesson: lesson)
                
            }
            editAction.backgroundColor = .green
            
            return [editAction]
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UserTypeManager.shared.isUserStudent() {
            let lesson = dataModel.lessonsByUserType()[indexPath.row]
            showRegisterView(lesson: lesson)
        }
    }
}
