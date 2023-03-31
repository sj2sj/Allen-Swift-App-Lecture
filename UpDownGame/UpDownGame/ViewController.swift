//
//  ViewController.swift
//  UpDownGame
//
//  Created by 뜌딩 on 2023/03/31.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var mainLabel: UILabel!
  @IBOutlet weak var numberLabel: UILabel!
  
  //컴퓨터가 랜덤으로 숫자 선택 (1~10)
  var comNumber = Int.random(in: 1...10)
  
  //내가 선택한 숫자
  //var myNumber: Int = 1
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mainLabel.text = "선택하세요"
    numberLabel.text = ""
    
  }

  
  //숫자버튼 눌렸을 때
  @IBAction func buttonTapped(_ sender: UIButton) {
    //눌린 버튼 숫자 가져와서 레이블 변경
    guard let numString = sender.currentTitle else { return }
    numberLabel.text = numString
    
    //선택한 숫자를 변수에 저장
    //guard let num = Int(numString) else { return }
    //myNumber = num
  }
  
  
  @IBAction func selectButtonTapped(_ sender: UIButton) {
    guard let myNumString = numberLabel.text else { return }
    guard let myNumber = Int(myNumString) else { return }
    
    
    //컴퓨터의 숫자와 내가 선택한 숫자 비교!
    if comNumber > myNumber {
      mainLabel.text = "Up!"
    } else if comNumber < myNumber {
      mainLabel.text = "Down"
    } else {
      mainLabel.text = "Bingo!🌟"
    }
  }
  
  
  @IBAction func resetButtonTapped(_ sender: UIButton) {
    mainLabel.text = "선택하세요"
    numberLabel.text = ""
    
    comNumber = Int.random(in: 1...10)
  }
  
}

