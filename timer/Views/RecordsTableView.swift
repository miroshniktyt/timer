//
//  RecordsTableView.swift
//  timer
//
//  Created by Macbook Air on 09.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class RecordsTableView: UITableView {
    
    var records: [Record] = [] {
        didSet {
            reloadData()
        }
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        self.allowsSelection = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        self.register(RecordTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(RecordTableViewCell.self))
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecordsTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: NSStringFromClass(RecordTableViewCell.self)) as! RecordTableViewCell
        cell.record = records[indexPath.row]
        return cell
    }
            
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let separatorView = UIView()
        separatorView.backgroundColor = .separator
        return separatorView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
       if records.isEmpty {
            return .none
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && !records.isEmpty {
            records.remove(at: indexPath.row)
            StorageManager.savedRecords = records
        }
    }
    
}
