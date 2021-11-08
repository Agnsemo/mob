//
//  TeachersManager.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import Foundation
import SQLite3

class TeachersManager {
    
    // MARK: - Declarations
    static let shared = TeachersManager()
    var teachersDb: OpaquePointer?
    let kDbPath: String = "teachersDB.sqlite"
    var fileUrl: URL?
    
    // MARK: - Methods
    init() {
        teachersDb = openDatabase()
        createTeachersTable()
    }
    
    deinit {
        sqlite3_close(teachersDb)
    }
    
    func teachers() -> [Teacher] {
        return getTeachers()
    }
    
    func setTeachers() {
        saveTeacher(Constants.teacher1)
        saveTeacher(Constants.teacher2)
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
    
    private func createTeachersTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS teacher(name TEXT, surname TEXT, email TEXT, password TEXT);"
        var createTableStatement: OpaquePointer?
        guard sqlite3_prepare_v2(teachersDb, createTableString, -1, &createTableStatement, nil) == SQLITE_OK else {
            print("ERROR!, CREATE TABLE statement could not be prepared.")
            return
        }
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            print("ERROR!, favorite articles table could not be created.")
            return
        }
        sqlite3_finalize(createTableStatement)
    }
    
    private func saveTeacher(_ teacher: Teacher) {
        let insertStatementString = "INSERT INTO teacher(name, surname, email, password) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer?
        guard sqlite3_prepare_v2(teachersDb, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK else {
            print("ERROR!, INSERT statement could not be prepared.")
            return
        }
        sqlite3_bind_text(insertStatement, 1, (teacher.name as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, (teacher.surname as NSString?)?.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, (teacher.email as NSString?)?.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, (teacher.password as NSString?)?.utf8String, -1, nil)
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            print("ERROR!, Could not insert row.")
            return
        }
        sqlite3_finalize(insertStatement)
    }
    
    private func getTeachers() -> [Teacher] {
        let queryStatementString = "SELECT * FROM teacher;"
        var queryStatement: OpaquePointer?
        var teachers: [Teacher] = []
        guard sqlite3_prepare_v2(teachersDb, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK else {
            print("ERROR!, SELECT statement could not be prepared")
            return []
        }
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
            let surname = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
            let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
            let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
            teachers.append(Teacher(name: name, surname: surname, password: password, email: email))
        }
        sqlite3_finalize(queryStatement)
        return teachers
    }
}
