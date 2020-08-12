//
//  StopwatchViewController.swift
//  timer
//
//  Created by Macbook Air on 09.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    private var stopWatch: Stopwatch!
    
    private var timer: Timer?
        
    private var isTimerRunning: Bool = false {
        didSet {
            if isTimerRunning {
                timer = Timer.scheduledTimer(withTimeInterval: Consts.tickTime, repeats: true, block: { (_) in
                    self.timeLabel.text = self.stopWatch.elapsedTime.formattedTimerString
                })
            } else {
                timer?.invalidate()
                self.timeLabel.text = self.stopWatch.elapsedTime.formattedTimerString
            }
        }
    }
    
    private var compactHeightConstraints: [NSLayoutConstraint] = []
    private var regularHeightConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    // MARK: Subviews
    
    private let timeLabel = StopwatchLabel()
    
    private let recordsView: RecordsTableView = {
        let table = RecordsTableView()
        table.records = StorageManager.savedRecords
        return table
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopWatch = StorageManager.savedStopwatch
        setupUI()
        setupGestures()
        isTimerRunning = stopWatch.isRunning
        NotificationCenter.default.addObserver(self, selector: #selector(saveActiveTimerData), name: Notification.Name("applicationWillTerminate"), object: nil)
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(timeLabel)
        view.addSubview(recordsView)

        NSLayoutConstraint.activate([
            timeLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.62),
            timeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            recordsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recordsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            recordsView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: -16),
            recordsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        timeLabel.text = stopWatch.elapsedTime.formattedTimerString
    }
    
    fileprivate func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        view.addGestureRecognizer(DoubleTapGestureRecognizer(target: self, action: #selector(viewDoubleTapped(_:))))
    }
    
    // MARK: Methods
    
    @objc private func viewTapped() {
        if stopWatch.isRunning {
            pause()
        } else {
            start()
        }
    }
    
    @objc private func viewDoubleTapped(withDoubleTapDuration tapDuration: TimeInterval) {
        stop(withDoubleTapDuration: tapDuration)
    }
    
    @objc private func viewDoubleTapped(_ gestureRecognizer: DoubleTapGestureRecognizer) {
        guard let doubleTapDuration = gestureRecognizer.timeIntervalSincePreviousTap else { return }
        stop(withDoubleTapDuration: doubleTapDuration)
    }
    
    @objc func tick() {
        timeLabel.text = stopWatch.elapsedTime.formattedTimerString
    }
        
    func start() {
        stopWatch.start()
        isTimerRunning = true
    }
    
    func pause() {
        stopWatch.pause()
        isTimerRunning = false
    }
    
    func stop(withDoubleTapDuration doubleTapDuration: TimeInterval) {
        stopWatch.pause()
        stopWatch.pausedTime -= doubleTapDuration
        isTimerRunning = false
        presentSavingAlert()
        self.stopWatch.stop()
    }
    
    private func presentSavingAlert() {
        let alert = UIAlertController(title: nil, message: "Save your time", preferredStyle: .alert)
                
        alert.addTextField { (textField) in
            textField.placeholder = "Type someting (optional)"
            textField.clearButtonMode = .whileEditing
        }
                
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.timeLabel.text = self.stopWatch.elapsedTime.formattedTimerString
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            let title = alert.textFields?.first?.text
            let record = Record(title: title, timeInterval: self.stopWatch.elapsedTime)
            self.recordsView.records.insert(record, at: 0)
            StorageManager.savedRecords = self.recordsView.records
            self.timeLabel.text = self.stopWatch.elapsedTime.formattedTimerString
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func saveActiveTimerData() {
        StorageManager.savedStopwatch = .init(startDate: stopWatch.startDate, pausedTime: stopWatch.pausedTime)
    }
    
}
