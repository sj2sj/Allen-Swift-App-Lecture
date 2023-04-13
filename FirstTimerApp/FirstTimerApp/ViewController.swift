//
//  ViewController.swift
//  FirstTimerApp
//
//  Created by 뜌딩 on 2023/04/12.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  @IBOutlet weak var mainLabel: UILabel!
  
  @IBOutlet weak var slider: UISlider!
  
  
  weak var timer: Timer?
  
  var number: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }

  //viewDidLoad 설정
  func configureUI() {
    mainLabel.text = "초를 선택하세요"
    slider.value = 0.5
  }
  
  
  @IBAction func sliderChanged(_ sender: UISlider) {
    //슬라이더의 value값 가지고 mainLabel text 설정
    // 기본값 0.0~1.0이기 때문에 x60
    number = Int(sender.value * 60)
    mainLabel.text = "\(number)초"
  }

  
  @IBAction func startButtonTapped(_ sender: UIButton) {
    timer?.invalidate()
    
    //timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(doSomethingAfter1Second), userInfo: nil, repeats: true)
    
    
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
      //반복할 코드
      
      if number > 0 {
        number -= 1
        //slider.value에는 0.0~1.0만 들어갈 수 있기 때문에 따로 설정
        slider.value = Float(number) / Float(60)
        mainLabel.text = "\(number)초"
        
      } else {
        number = 0
        mainLabel.text = "초를 선택하세요"
        
        timer?.invalidate()
        AudioServicesPlayAlertSound(SystemSoundID(1016))
      }
      
      
    }

    
  }
  
  @objc func doSomethingAfter1Second() {
    if number > 0 {
      number -= 1
      //slider.value에는 0.0~1.0만 들어갈 수 있기 때문에 따로 설정
      slider.value = Float(number) / Float(60)
      mainLabel.text = "\(number)초"
      
    } else {
      number = 0
      mainLabel.text = "초를 선택하세요"
      
      timer?.invalidate()
      AudioServicesPlayAlertSound(SystemSoundID(1322))
    }
  }
  
  
  @IBAction func resetButtonTapped(_ sender: UIButton) {
    mainLabel.text = "초를 선택하세요"
    slider.value = 0.5
    number = 0
    timer?.invalidate()
    //slider.setValue(0.5, animated: true)
  }
  
}


