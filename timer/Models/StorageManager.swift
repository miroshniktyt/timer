//
//  StorageManager.swift
//  timer
//
//  Created by Macbook Air on 10.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

struct StorageManager {
    
    private static let recordsKey = "saved_records_list"
    private static let pousedTimeKey = "interapted_timer"
    
    static var savedRecords: [Record] {
        get {
            return getRecords()
        }
        set {
            saveRecords(newValue)
        }
    }
    
    static var savedStopwatch: Stopwatch? {
        get {
            return getStopWatch()
        }
        set {
            saveStopwatch(newValue)
        }
    }
    
    // MARK: methods
    
    private static func getRecords() -> [Record] {
        guard let recordsData = UserDefaults.standard.data(forKey: recordsKey) else {
            return []
        }
        
        do {
            let records = try JSONDecoder().decode([Record].self, from: recordsData)
            return records
        } catch {
            print(error)
            return []
        }
    }
    
    private static func saveRecords(_ records: [Record]) {
        do {
            let recordsData = try JSONEncoder().encode(records)
            UserDefaults.standard.set(recordsData, forKey: recordsKey)
        } catch {
            print(error, "Can't save recordsData")
        }
    }
    
    private static func getStopWatch() -> Stopwatch? {
        guard let stopwatchData = UserDefaults.standard.data(forKey: pousedTimeKey) else {
            return nil
        }
        
        do {
            let stopwatchModel = try JSONDecoder().decode(Stopwatch.self, from: stopwatchData)
            return stopwatchModel
        } catch {
            print(error)
            return nil
        }
    }
    
    private static func saveStopwatch(_ records: Stopwatch?) {
        do {
            let stopwatchData = try JSONEncoder().encode(records)
            UserDefaults.standard.set(stopwatchData, forKey: pousedTimeKey)
        } catch {
            print(error, "Can't save stopwatchData")
        }
    }
        
}
