//
//  LoginStudentsManager.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import Foundation
import SQLite3

class LoginStudentsManager {
    
    // MARK: - Declarations
    static let shared = LoginStudentsManager()
    var studentsDb: OpaquePointer?
    let kDbPath: String = "LoginstudentsDB2.sqlite"
    var fileUrl: URL?
    
    // MARK: - Methods
    init() {
        studentsDb = openDatabase()
        createStudentsTable()
    }
    
    deinit {
        sqlite3_close(studentsDb)
    }
    
    func students() -> [Student] {
        return getStudent()
    }
    
    func saveStudent(_ student: Student) {
         let insertStatementString = "INSERT INTO studentLogin(name, surname, email, groupNR, password) VALUES (?, ?, ?, ?, ?);"
         var insertStatement: OpaquePointer?
         guard sqlite3_prepare_v2(studentsDb, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK else {
             print("ERROR!, INSERT statement could not be prepared.")
             return
         }
         sqlite3_bind_text(insertStatement, 1, (student.name as NSString).utf8String, -1, nil)
         sqlite3_bind_text(insertStatement, 2, (student.surname as NSString?)?.utf8String, -1, nil)
         sqlite3_bind_text(insertStatement, 3, (student.email as NSString?)?.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, (student.group as NSString?)?.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 5, (student.password as NSString?)?.utf8String, -1, nil)
         guard sqlite3_step(insertStatement) == SQLITE_DONE else {
             print("ERROR!, Could not insert row.")
             return
         }
         sqlite3_finalize(insertStatement)
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
    
    private func createStudentsTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS studentLogin(name TEXT, surname TEXT, email TEXT, groupNR TEXT, password TEXT);"
        var createTableStatement: OpaquePointer?
        guard sqlite3_prepare_v2(studentsDb, createTableString, -1, &createTableStatement, nil) == SQLITE_OK else {
            print("ERROR!, CREATE TABLE statement could not be prepared.")
            return
        }
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            print("ERROR!, favorite articles table could not be created.")
            return
        }
        sqlite3_finalize(createTableStatement)
    }
    
    private func getStudent() -> [Student] {
        let queryStatementString = "SELECT * FROM studentLogin;"
        var queryStatement: OpaquePointer?
        var students: [Student] = []
        guard sqlite3_prepare_v2(studentsDb, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK else {
            print("ERROR!, SELECT statement could not be prepared")
            return []
        }
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
            let surname = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
            let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
            let group = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
            let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
            students.append(Student(name: name, surname: surname, password: password, email: email, group: group))
        }
        sqlite3_finalize(queryStatement)
        return students
    }
}
