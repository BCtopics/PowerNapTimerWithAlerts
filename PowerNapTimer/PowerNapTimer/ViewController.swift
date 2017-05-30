//
//  ViewController.swift
//  PowerNapTimer
//
//  Created by James Pacheco on 4/12/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TimerDelegate {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    let myTimer = MyTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTimer.delegate = self
        
        setView()
    }
    
    func setView() {
        updateTimerLabel()
        // If timer is running, start button title should say "Cancel". If timer is not running, title should say "Start nap"
        if myTimer.isOn {
            startButton.setTitle("Cancel", for: UIControlState())
        } else {
            startButton.setTitle("Start nap", for: UIControlState())
        }
    }
    
    func updateTimerLabel() {
        timerLabel.text = myTimer.timeAsString()
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if myTimer.isOn {
            myTimer.stopTimer()
        } else {
            myTimer.startTimer(10)
        }
        setView()
    }
    
    // MARK: - TimerDelegate Functions
    
    func timerStopped() {
        setView()
        myTimer.timer?.invalidate()
    }
    
    func timerCompleted() {
        setView()
        presentIsCompletedAlert()
    }
    
    func timerSecondtick() {
        updateTimerLabel()
    }
    
    // MARK: - AlertController

    func presentIsCompletedAlert() {
        
        var snoozeTextField: UITextField?
        // Create The Alert Controller
        let alertController = UIAlertController(title: "Nap is over man!", message: "Get out of bed!", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            snoozeTextField = textField
            snoozeTextField?.placeholder = "How many more minuets?"
            snoozeTextField?.keyboardType = .numberPad
        }
        
        // Create Actions
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let snoozeAction = UIAlertAction(title: "Snooze", style: .default) { (_) in
            guard let timeText = snoozeTextField?.text, let time = TimeInterval(timeText) else { return }
            self.myTimer.startTimer(time * 60)
            self.setView()
        }
        
        // Add Action
        alertController.addAction(dismissAction)
        alertController.addAction(snoozeAction)
        
        // Present Alert Controller
        present(alertController, animated: true, completion: nil)
    }
}















