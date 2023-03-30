//
//  ViewController.swift
//  RPSGame
//
//  Created by 뜌딩 on 2023/03/30.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var mainLabel: UILabel!
  
  @IBOutlet weak var comImageView: UIImageView!
  @IBOutlet weak var myImageView: UIImageView!
  
  @IBOutlet weak var comChoiceLabel: UILabel!
  @IBOutlet weak var myChoiceLabel: UILabel!
  
  var myChoice: Rps = Rps.rock
  var comChoice: Rps = Rps(rawValue: Int.random(in: 0...2))!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //이미지 할당
    comImageView.image = #imageLiteral(resourceName: "ready")
    myImageView.image = UIImage(named: "ready.png")
    
    //문자열 세팅
    comChoiceLabel.text = "준비"
    myChoiceLabel.text = "준비"
  }

  
  //가위바위보 버튼
  @IBAction func rpsButtonTapped(_ sender: UIButton) {
    //guard let title = sender.currentTitle else {return}
    
    let title = sender.currentTitle!
    
    switch title {
    case "가위":
      myChoice = Rps.scissors
    case "바위":
      myChoice = Rps.rock
    case "보":
      myChoice = Rps.paper
    default:
      break
    }
    
  }
  
  
  @IBAction func selectButtonTapped(_ sender: UIButton) {
    
    //컴퓨터 선택에 따라 이미지, 텍스트 설정
    switch comChoice {
    case Rps.rock:
      comImageView.image = UIImage(named: "rock.png")
      comChoiceLabel.text = "바위"
    case Rps.paper:
      comImageView.image = UIImage(named: "paper.png")
      comChoiceLabel.text = "보"
    case Rps.scissors:
      comImageView.image = UIImage(named: "scissors.png")
      comChoiceLabel.text = "가위"
    }
    
    //내 선택에 따라 이미지, 텍스트 설정
    switch myChoice {
    case Rps.rock:
      myImageView.image = UIImage(named: "rock.png")
      myChoiceLabel.text = "바위"
    case Rps.paper:
      myImageView.image = UIImage(named: "paper.png")
      myChoiceLabel.text = "보"
    case Rps.scissors:
      myImageView.image = UIImage(named: "scissors.png")
      myChoiceLabel.text = "가위"
    }
    
    
    //결과
    if comChoice == myChoice {
      mainLabel.text = "비겼어요"
    } else if comChoice == .rock && myChoice == .paper {
      mainLabel.text = "이겼어요😀"
    } else if comChoice == .paper && myChoice == .scissors {
      mainLabel.text = "이겼어요😀"
    } else if comChoice == .scissors && myChoice == .rock {
      mainLabel.text = "이겼어요😀"
    } else {
      mainLabel.text = "졌어요😢"
    }
    
    
  }
  
  
  
  @IBAction func resetButtonTapped(_ sender: UIButton) {
    comImageView.image = UIImage(named: "ready.png")
    comChoiceLabel.text = "준비"
    
    myImageView.image = UIImage(named: "ready.png")
    myChoiceLabel.text = "준비"
    
    mainLabel.text = "선택하세요"
    
    comChoice = Rps(rawValue: Int.random(in: 0...2))!
  }
  
  
  
}

