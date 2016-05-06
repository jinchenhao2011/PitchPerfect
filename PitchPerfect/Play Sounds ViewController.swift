//
//  Play Sounds ViewController.swift
//  PitchPerfect
//
//  Created by Detrick Jin on 4/28/16.
//  Copyright © 2016 Detrick Jin. All rights reserved.
//

import UIKit
import AVFoundation

class Play_Sounds_ViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipButton: UIButton!
    @IBOutlet weak var dartButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!

    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    var audioPlayer: AVAudioPlayer?
    var time: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
        
        // Create AVAudio player to count the duration of the record
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: recordedAudioURL, fileTypeHint: nil)
        } catch {
            audioPlayer = nil
        }
        
        // Save the time of the recordfile
        time = audioPlayer!.duration
        time = round(time*100)/100
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
        
        // Create the text of the label
        timeLabel.text = "Time: \(time)s"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }
    
    @IBAction func playSoundsButton(sender: UIButton) {
        print("Play sounds button pressed")
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
            
        }
        configureUI( .Playing)
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        print("Stop audio button pressed")
        stopAudio()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
