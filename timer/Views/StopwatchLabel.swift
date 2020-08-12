//
//  StopwatchLabel.swift
//  timer
//
//  Created by Macbook Air on 11.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class StopwatchLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        self.textAlignment = .center
        self.font = .inAppBig
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.1
        self.baselineAdjustment = .alignCenters
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
//        resetFont()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
