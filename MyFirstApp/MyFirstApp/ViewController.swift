//
//  ViewController.swift
//  MyFirstApp
//
//  Created by 뜌딩 on 2023/03/29.
//

import UIKit

class ViewController: UIViewController {

  
  @IBOutlet weak var mainLabel: UILabel!
  @IBOutlet weak var myButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
  }


  
  @IBAction func buttonPressed(_ sender: UIButton) {
    mainLabel.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    mainLabel.textColor = #colorLiteral(red: 0.9757187963, green: 0.9428607821, blue: 0.5474837422, alpha: 1)
    
    mainLabel.text = "안녕하세요! 😀"
    mainLabel.textAlignment = NSTextAlignment.right //텍스트 오른쪽정렬
    
    myButton.backgroundColor = UIColor.blue
    myButton.setTitleColor(UIColor.yellow, for: UIControl.State.normal)
    //mainLabel.backgroundColor = UIColor.yellow
  }
  
  
  
}

