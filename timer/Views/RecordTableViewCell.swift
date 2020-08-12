//
//  RecordTableViewCell.swift
//  timer
//
//  Created by Macbook Air on 09.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .inAppSmall
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .inAppItalic
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var record: Record? {
        didSet {
            guard let record = record else { return }
            
            timeLabel.text = record.timeString
            titleLabel.text = record.title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        let stack = UIStackView(arrangedSubviews: [timeLabel, titleLabel])
        stack.spacing = 16
        stack.distribution = .fillEqually

        addSubview(stack)
        stack.fillSuperview(insets: .init(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
