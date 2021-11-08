//
//  GetLecturesOperation.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-11-08.
//

import UIKit

class GetLecturesOperation {
    
    func getLectures() {
        guard let requestURL: NSURL = NSURL(string: "https://uais.cr.ktu.lt/ktuis/tv_rprt2.ical1?p=C8753&t=basic.ics") else {
            return
        }
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                guard let data = data else {
                    return
                }
                self.getResult(data: data)
            } else  {
                print("FAILED")
            }
        }
        task.resume()
    }
    
    func getResult(data: Data) {
        guard let string = String(data: data, encoding: .utf8) else {
            print("ERROR, there is no data")
            return
        }
        let icsContent = string.components(separatedBy: "\n")
        let result = parse(icsContent)
        print("ASD", result)
    }
    
    func parse(_ icsContent: [String]) -> [Calendar] {
        let parser = Parser(icsContent)
        do {
            return try parser.read()
        } catch let error {
            print("ASD ERROR", error)
            return []
        }
    }
    
    
//    func getLectures() {
//        guard let url = URL(string: "https://uais.cr.ktu.lt/ktuis/tv_rprt2.ical1?p=C8753&t=basic.ics") else {
//            print("ERROR!, url is nil")
//            return
//        }
//        var cals: [Calendar] = []
//        do {
//            cals = try iCal.load(url: url)
//            print("ASD", cals)
//        } catch {
//            print("ERROR:", error)
//        }
//
//        for cal in cals {
//            for event in cal.subComponents where event is Event {
//                print("ASD", event)
//            }
//        }
//    }
}
