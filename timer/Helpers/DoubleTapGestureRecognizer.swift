//
//  DoubleTapGestureRecognizer.swift
//  timer
//
//  Created by Macbook Air on 12.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class DoubleTapGestureRecognizer: UITapGestureRecognizer {
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        numberOfTapsRequired = 2
    }
    
    private var savedTouchDate: Date?
    
    var timeIntervalSincePreviousTap: TimeInterval?
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        
        if let savedTouchDate = savedTouchDate {
            timeIntervalSincePreviousTap = -savedTouchDate.timeIntervalSinceNow
        }
        savedTouchDate = Date()
    }
}
