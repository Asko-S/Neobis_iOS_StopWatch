//  ViewController.swift
//  Neobis_iOS_StopWatch
//  Created by Askar Soronbekov

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - IBOutlets
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!

    private var timer = Timer()
    private var timeNumber = 0
    private var timerRunning = false
    private var isStopwatchMode = false
    private let hourRange = Array(0...23)
    private let minuteRange = Array(0...59)
    private let secondRange = Array(0...59)

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
    }

    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
    }
    
    private func startTimer() {
        if !timerRunning {
            timerRunning = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            stopButton.isEnabled = false
        }
    }
    
    private func stopTimer() {
        if timerRunning {
            timer.invalidate()
            timerRunning = false
            stopButton.isEnabled = true
        }
    }
    
    private func resetTimer() {
        timer.invalidate()
        timerRunning = false
        timeLabel.text = "00:00:00"
        timeNumber = 0
    }
    
    private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    private func formatTime(hours: Int, minutes: Int, seconds: Int) -> String {
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
 
    @IBAction func segmentAction(_ sender: Any) {
        pickerView.isHidden = false
        isStopwatchMode = segmentControl.selectedSegmentIndex == 1
    }
    
    @IBAction func startAction(_ sender: Any) {
        startTimer()
    }
    
    @IBAction func stopAction(_ sender: Any) {
        stopTimer()
    }
    
    @IBAction func resetAction(_ sender: Any) {
        resetTimer()
    }

    @objc private func updateTimer() {
        if isStopwatchMode {
            if timeNumber > 0 {
                timeNumber -= 1
            } else {
                stopTimer()
            }
        } else {
            timeNumber += 1
        }
        
        let time = secondsToHoursMinutesSeconds(seconds: timeNumber)
        let timerString = formatTime(hours: time.0, minutes: time.1, seconds: time.2)
        timeLabel.text = timerString
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return hourRange.count
        case 1: return minuteRange.count
        case 2: return secondRange.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return String(format: "%02d", hourRange[row])
        case 1: return String(format: "%02d", minuteRange[row])
        case 2: return String(format: "%02d", secondRange[row])
        default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedHours = hourRange[pickerView.selectedRow(inComponent: 0)]
        let selectedMinutes = minuteRange[pickerView.selectedRow(inComponent: 1)]
        let selectedSeconds = secondRange[pickerView.selectedRow(inComponent: 2)]
        timeNumber = (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
        let timeString = formatTime(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds)
        timeLabel.text = timeString
    }
}
