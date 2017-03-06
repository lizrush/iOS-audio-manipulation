//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by liz on 2/3/17.
//  Copyright © 2017 liz. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

  @IBOutlet weak var outerStackView: UIStackView!
  @IBOutlet weak var innerStackView1: UIStackView!
  @IBOutlet weak var innerStackView2: UIStackView!
  @IBOutlet weak var innerStackView3: UIStackView!

  @IBOutlet weak var snailButton: UIButton!
  @IBOutlet weak var chipmunkButton: UIButton!
  @IBOutlet weak var rabbitButton: UIButton!
  @IBOutlet weak var vaderButton: UIButton!
  @IBOutlet weak var echoButton: UIButton!
  @IBOutlet weak var reverbButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!

  var recordedAudioURL:URL!
  var audioFile:AVAudioFile!
  var audioEngine:AVAudioEngine!
  var audioPlayerNode: AVAudioPlayerNode!
  var stopTimer: Timer!

  enum ButtonType: Int {
    case slow = 0, fast, chipmunk, vader, echo, reverb
  }

  @IBAction func playSoundForButton(_ sender: UIButton) {
    switch(ButtonType(rawValue: sender.tag)!) {
    case .slow:
      playSound(rate: 0.5)
    case .fast:
      playSound(rate: 1.5)
    case .chipmunk:
      playSound(pitch: 1000)
    case .vader:
      playSound(pitch: -1000)
    case .echo:
      playSound(echo: true)
    case .reverb:
      playSound(reverb: true)
    }

    configureUI(.playing)
  }

  @IBAction func stopButtonPressed(_ sender: AnyObject) {
    stopAudio()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureUI(.notPlaying)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupAudio()
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    coordinator.animate(alongsideTransition: { (context) -> Void in
      let orientation = UIApplication.shared.statusBarOrientation

      if orientation.isPortrait{
        self.outerStackView.axis = .vertical
        self.setInnerStackViewsAxis(axisStyle: .horizontal)
      } else {
        self.outerStackView.axis = .horizontal
        self.setInnerStackViewsAxis(axisStyle: .vertical)
      }
    }, completion: nil)
  }

  func setInnerStackViewsAxis(axisStyle: UILayoutConstraintAxis)  {
    self.innerStackView1.axis = axisStyle
    self.innerStackView2.axis = axisStyle
    self.innerStackView3.axis = axisStyle
  }
}
