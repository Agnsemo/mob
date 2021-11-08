//
//  LessonsMannager.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-13.
//

import Foundation
import SQLite3

class RegisterToLessonsManager {
    
    // MARK: - Declarations
    static let shared = RegisterToLessonsManager()
    var lessonsDB: OpaquePointer?
    let kDbPath: String = "registerToLessons.sqlite"
    var fileUrl: URL?
    
    // MARK: - Methods
    init() {
        lessonsDB = openDatabase()
        createLessonsTable()
    }
    
    deinit {
        sqlite3_close(lessonsDB)
    }
    
    func lessons() -> [Lesson] {
        return getLessons()
    }
    
    private func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory,
                                                      in: .userDomainMask,
                                                      appropriateFor: nil,
                                                      create: false)
            .appendingPathComponent(kDbPath)
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        }
        else {
            print("Successfully opened connection to database at \(kDbPath)")
            return db
        }
    }
    
    private func createLessonsTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS registerToLessons(id TEXT, name TEXT, date TEXT, groupID TEXT, place TEXT, teacherName TEXT);"
        var createTableStatement: OpaquePointer?
        guard sqlite3_prepare_v2(lessonsDB, createTableString, -1, &createTableStatement, nil) == SQLITE_OK else {
            print("ERROR!, CREATE TABLE statement could not be prepared.")
            return
        }
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            print("ERROR!, favorite articles table could not be created.")
            return
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func saveLesson(_ lesson: Lesson) {
        let insertStatementString = "INSERT INTO registerToLessons(id, name, date, groupID, place, teacherName) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer?
        guard sqlite3_prepare_v2(lessonsDB, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK else {
            print("ERROR!, INSERT statement could not be prepared.")
            return
        }
        sqlite3_bind_text(insertStatement, 1, (lesson.id as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, (lesson.name as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, (lesson.date as NSString?)?.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, (lesson.group as NSString?)?.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 5, (lesson.place as NSString?)?.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 6, (lesson.teacherName as NSString?)?.utf8String, -1, nil)
        
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            print("ERROR!, Could not insert row.")
            return
        }
        sqlite3_finalize(insertStatement)
    }
    
    private func getLessons() -> [Lesson] {
        let queryStatementString = "SELECT * FROM registerToLessons;"
        var queryStatement: OpaquePointer?
        var lessons: [Lesson] = []
        guard sqlite3_prepare_v2(lessonsDB, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK else {
            print("ERROR!, SELECT statement could not be prepared")
            return []
        }
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
            let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
            let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
            let group = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
            let place = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
            let teacherName = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
            lessons.append(Lesson(id: id, name: name, date: date, group: group, place: place, teacherName: teacherName))
        }
        sqlite3_finalize(queryStatement)
        return lessons
    }
}
