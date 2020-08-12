//
//  StopwatchModal.swift
//  timer
//
//  Created by Macbook Air on 11.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

struct Stopwatch: Codable {
    var startDate: Date?
    var pausedTime: TimeInterval
}

extension Stopwatch {
    var elapsedTime: TimeInterval {
        if let startTime = startDate {
            return -startTime.timeIntervalSinceNow + pausedTime
        } else {
            return pausedTime
        }
    }

    var isRunning: Bool {
        return startDate != nil
    }

    mutating func start() {
        startDate = Date()
    }

    mutating func pause() {
        pausedTime = elapsedTime
        startDate = nil
    }

    mutating func stop() {
        pausedTime = 0
        startDate = nil
    }

}
