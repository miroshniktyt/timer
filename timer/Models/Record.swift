//
//  Record.swift
//  timer
//
//  Created by Macbook Air on 09.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

struct Record: Codable {
    let title: String?
    let timeInterval: TimeInterval
}

extension Record {
    var timeString: String {
        return timeInterval.formattedTimerString
    }
}
