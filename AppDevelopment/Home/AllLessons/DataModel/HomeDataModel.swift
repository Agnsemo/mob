//
//  HomeDataModel.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-13.
//

import Foundation

class HomeDataModel {
    
    private var lessons: [Lesson] = []
    private var visibleLessons: [Lesson] = []
    private var onUpdate: (() -> Void)
    private var searchText: String?
    var sortType: LessonSortType = .none
    
    init(onUpdate: @escaping(() -> Void)) {
        self.onUpdate = onUpdate
    }
    
    func updateLessons() {
        lessons = LessonsMannager.shared.lessons()
        updateVisibleLessonList()
        onUpdate()
    }
    
    private func updateVisibleLessonList() {
        visibleLessons = lessons.filteredBy(searchText: searchText).sortedBy(sortType: sortType)
    }
    
    func lessonsByUserType() -> [Lesson] {
        if let student = UserTypeManager.shared.student {
            return visibleLessons.filter{ $0.group == student.group }
        }
        if UserTypeManager.shared.isUserTecher() {
            return visibleLessons
        }
        return []
    }
    
    func filterLessons(by searchText: String) {
        self.searchText = searchText.count > 3 ? searchText : nil
        updateVisibleLessonList()
        onUpdate()
    }
    
    func sortLessons(by sortType: LessonSortType) {
        self.sortType = sortType
        updateVisibleLessonList()
        onUpdate()
    }
}
