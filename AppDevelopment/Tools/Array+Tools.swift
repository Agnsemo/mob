//
//  ArticleEntityArray+Tools.swift
//  NewsAppAgnSmn
//
//  Created by Agne  on 2021-07-13.
//

import Foundation

extension Array where Element == Lesson {
    
    func filteredBy(searchText: String?) -> [Lesson] {
        guard let searchText = searchText, !searchText.isEmpty else {
            return self
        }
        return filter { (lesson: Lesson) -> Bool in
            return lesson.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    func sortedBy(sortType: LessonSortType) -> [Lesson] {
        switch sortType {
        case .name:
            return sorted { $0.name < $1.name }
        case .date:
            return sorted { $0.date < $1.date }
        case .userRegisterToClasses:
            return RegisterToLessonsManager.shared.lessons()
        case .none:
            return self
        }
    }
}
