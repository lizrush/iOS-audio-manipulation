//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by liz on 11/5/16.
//  Copyright © 2016 liz. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

  var audioRecorder: AVAudioRecorder!

  @IBOutlet var recordLabel: UILabel!
  @IBOutlet var recordButton: UIButton!
  @IBOutlet var stopRecordButton: UIButton!

  @IBAction func recordAudio(_ sender: Any) {
    recordLabel.text = "Recording in progress..."
    stopRecordButton.isEnabled = true
    recordButton.isEnabled = false

    let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = URL(string: pathArray.joined(separator: "/"))

    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)

    try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }

  @IBAction func stopRecording(_ sender: Any) {
    recordLabel.text = "Tap to record"
    stopRecordButton.isEnabled = false
    recordButton.isEnabled = true
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
  }

  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
    } else {
      print("Recording failed to save")
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "stopRecording" {
      let playSoundsVC = segue.destination as! PlaySoundsViewController
      let recordedAudioURL = sender as! URL
      playSoundsVC.recordedAudioURL = recordedAudioURL
    }
  }
}

