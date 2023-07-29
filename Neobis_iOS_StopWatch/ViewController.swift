//  ViewController.swift
//  Neobis_iOS_StopWatch
//  Created by Askar Soronbekov

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SartButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var ResetButton: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startTapped(_ sender: Any) {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopTapped(_ sender: Any) {
        timerCounting = false
        timer.invalidate()
    }
    
    @objc func timerCounter() -> Void
        {
            count = count + 1
            let time = secondsToHoursMinutesSeconds(seconds: count)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            TimerLabel.text = timeString
        }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
        {
            return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
        }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
        {
            var timeString = ""
            timeString += String(format: "%02d", hours)
            timeString += " : "
            timeString += String(format: "%02d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString
        }
}

