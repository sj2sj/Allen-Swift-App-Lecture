//
//  ViewController.swift
//  TextFieldProject
//
//  Created by 뜌딩 on 2023/04/13.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  
  @IBOutlet weak var textField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textField.delegate = self
    
    setup()
  }
  
  func setup() {
    //view 설정
    view.backgroundColor = UIColor.gray
    
    textField.keyboardType = UIKeyboardType.emailAddress
    textField.placeholder = "이메일 입력"
    textField.borderStyle = .roundedRect
    textField.clearButtonMode = .always
    textField.returnKeyType = .next
  
    //화면 진입 시 키보드 떠있는 상태로
    textField.becomeFirstResponder()
  }
  
  //화면의 탭을 감지하는 메서드
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    // == textField.resignFirstResponder()
  }

  //텍스트 필드의 입력을 시작할때 호출되는 메서드
  //(시작할지 말지의 여부 허락)
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    print(#function)
    return true
  }
  
  //보통 Bool이 반환타입이 아닌 경우 시점을 의미하는 경우가 많음
  //텍스트필드 입력이 시작됐을 경우 호출
  func textFieldDidBeginEditing(_ textField: UITextField) {
    print(#function)
    print("유저가 텍스트필드의 입력을 시작함")
  }
  
  //clear버튼의 동작 가능 여부
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    print(#function)
    return true
  }
  
  //텍스트필드에 글자를 입력 or 지울 때 마다 실행되는 함수
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    //입력되는 글자가 숫자이면 입력 허용X
    if Int(string) != nil {
      return false
    } else {
      //10글자 이상 입력 금지
      guard let text = textField.text else {return true}
      let newLength = text.count + string.count - range.length
      return newLength <= 10
    }
    
    
    //텍스트필드 입력 글자 수를 10글자로 제한
//    let maxLength = 10
//    let currentString: NSString = (textField.text ?? "") as NSString
//    let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//
//    return newString.length <= maxLength
  }
  
  //텍스트필드의 엔터 키가 눌러지면 다음 동작을 허락할 것인지? 말 것인지
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    print(#function)
    
    if textField.text == "" {
      textField.placeholder = "Type Something!"
      return false
    } else {
      return true
    }
  }

  //텍스트필드의 입력이 끝날 때 호출 (끝날지 말지를 허락)
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    print(#function)
    return true
  }
  
  //텍스트필드의 입력이 끝났을 때 호출 (시점)
  func textFieldDidEndEditing(_ textField: UITextField) {
    print(#function)
    print("유저가 텍스트 필드의 입력을 끝냄")
    textField.text = ""
  }
  
  
  @IBAction func doneButtonTapped(_ sender: UIButton) {
    //키보드 내림
    textField.resignFirstResponder()
  }
  
  
}

