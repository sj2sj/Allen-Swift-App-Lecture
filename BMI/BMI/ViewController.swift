//
//  ViewController.swift
//  BMI
//
//  Created by 뜌딩 on 2023/05/09.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var mainLabel: UILabel!
  @IBOutlet weak var heightTextField: UITextField!
  @IBOutlet weak var weightTextField: UITextField!
  
  @IBOutlet weak var calculateButton: UIButton!
  
  var bmi: Double?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    makeUI()
  }

  func makeUI() {
    heightTextField.delegate = self
    weightTextField.delegate = self
    
    mainLabel.text = "키와 몸무게를 입력해주세요."
    calculateButton.clipsToBounds = true
    calculateButton.layer.cornerRadius = 5
    calculateButton.setTitle("BMI 계산하기", for: .normal)
    heightTextField.placeholder = "cm 단위로 입력해주세요."
    weightTextField.placeholder = "kg 단위로 입력해주세요."
  }

  // 계산하기 버튼 눌렀을 때
  @IBAction func calculateButtonTapped(_ sender: UIButton) {
    bmi = calculateBMI(height: heightTextField.text!, weight: weightTextField.text!)
  }
  
  //화면 전환
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    if heightTextField.text == "" || weightTextField.text == "" {
      mainLabel.text = "키와 몸무게를 입력하셔야 합니다!"
      mainLabel.textColor = UIColor.red
      return false
    }
    mainLabel.text = "키와 몸무게를 입력해주세요"
    mainLabel.textColor = UIColor.black
    return true
  }
  
  //화면 전환 시 데이터 전달
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toSecondVC" {
      let secondVC = segue.destination as! SecondViewController
      
      //계산된 결과값 다음화면으로 전달
      secondVC.bmiNumber = self.bmi
      secondVC.bmiColor = getBackgroundColor()
      secondVC.adviceString = getBMIAdvicString()
    }
    
    //화면 전환 시 텍스트필드 값 지움
    heightTextField.text = ""
    weightTextField.text = ""
  }
  
  func calculateBMI(height: String, weight: String) -> Double {
    guard let h = Double(height), let w = Double(weight) else {return 0.0}
    var bmi = w / (h * h) * 10000
    print(bmi)
    bmi = round(bmi * 10) / 10
    return bmi
  }
  
  //bmi에 따라 색깔 얻는 메서드
  func getBackgroundColor() -> UIColor {
    guard let bmi = bmi else {return UIColor.black}
    switch bmi {
    case ..<18.6:
      return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
    case 18.6..<23.0:
      return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
    case 23.0..<25.0:
      return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
    case 25.0..<30.0:
      return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
    case 30.0...:
      return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
    default:
      return UIColor.black
    }
  }
  
  //bmi에 따라 문자열을 얻어내는 메서드
  func getBMIAdvicString() -> String {
    guard let bmi = bmi else {return ""}
    switch bmi {
    case ..<18.6:
      return "저체중"
    case 18.6..<23.0:
      return "표준"
    case 23.0..<25.0:
      return "과체중"
    case 25.0..<30.0:
      return "중도비만"
    case 30.0...:
      return "고도비만"
    default:
      return ""
    }
  }
  
  
}

extension ViewController: UITextFieldDelegate {
  
  //텍스트필드 입력시마다 호출
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    //숫자로 변환이 된다면 (입력된 문자가 숫자라면)
    if Int(string) != nil || string == "" {
      return true //글자 입력 허용
    }
    return false //글자 입력 허용 X
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //2개의 텍스트필드를 모두 종료 (키보드 내림)
    if heightTextField.text != "", weightTextField.text != "" {
      weightTextField.resignFirstResponder()
      return true
    } else if heightTextField.text != "" { //2번째 텍스트필드로 넘어감
      weightTextField.becomeFirstResponder()
      return true
    }
    return false
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    heightTextField.resignFirstResponder()
    weightTextField.resignFirstResponder()
  }
  
  
  
}

