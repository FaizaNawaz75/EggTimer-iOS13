//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var player: AVAudioPlayer!

    let eggTime = ["Soft": 3, "Medium": 5, "Hard": 7]
    var secondsPassed: Float = 0;
    var totalTime: Float = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        totalTime = Float((eggTime[hardness])!)
        
        reset()
        startTimer()
    }
    
    fileprivate func reset() {
        secondsPassed = 0;
        progressBar.progress = 0
        statusLabel.text = "Starting..."
        timer.invalidate()
        if(player != nil) {
            player.stop()
        }
    }
    
    fileprivate func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func updateTimer() {
        
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            progressBar.progress = secondsPassed/totalTime
        }
        else {
            statusLabel.text = "Done"
            timer.invalidate()
            playAlarm()
        }
    }
    
    fileprivate func playAlarm() {

        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
