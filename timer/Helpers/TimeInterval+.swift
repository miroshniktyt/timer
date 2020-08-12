//
//  TimeInterval+.swift
//  timer
//
//  Created by Macbook Air on 10.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

// TODO: Need Unit testing

extension TimeInterval {
    var formattedTimerString: String {
        return String(
            format: "%02d:%02d,%d",
            Int(self / 60),
            Int(self.truncatingRemainder(dividingBy: 60)),
            Int((self * 10).truncatingRemainder(dividingBy: 10))
        )
    }
}
