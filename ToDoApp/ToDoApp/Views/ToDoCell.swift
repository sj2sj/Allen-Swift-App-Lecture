//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by 뜌딩 on 2023/07/27.
//

import UIKit

final class ToDoCell: UITableViewCell {
  
  @IBOutlet weak var bgView: UIView!
  
  @IBOutlet weak var toDoTextLabel: UILabel!
  @IBOutlet weak var dateTextLabel: UILabel!
  @IBOutlet weak var updateButton: UIButton!
  
  
  // ToDoData를 전달받을 변수 (전달 받으면, 표시하는 메서드를 실행🌟)
  var toDoData: ToDoData? {
    didSet {
      configureUIwithData()
    }
  }
  
  //델리게이트 대신, 실행하고 싶은 클로저를 저장
  //뷰컨트롤러에 있는 클로저를 저장할 예정
  //(셀(자신)을 전달)
  var updateButtonPressed: (ToDoCell) -> Void = { (sender) in }
  
  // 스토리보드 생성자
  override func awakeFromNib() {
    super.awakeFromNib()
    configureUI()
  }
  
  // 기본 UI 설정
  func configureUI() {
    bgView.clipsToBounds = true
    bgView.layer.cornerRadius = 8
    
    updateButton.clipsToBounds = true
    updateButton.layer.cornerRadius = 10
  }
  
  // 데이터를 가지고 적절한 UI표시
  func configureUIwithData() {
    toDoTextLabel.text = toDoData?.memoText
    dateTextLabel.text = toDoData?.dateString
    guard let colorNum = toDoData?.color else { return }
    let color = MyColor(rawValue: colorNum) ?? .red
    updateButton.backgroundColor = color.buttonColor
    bgView.backgroundColor = color.backgroundColor
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  //UPDATE 버튼 눌렸을 때
  @IBAction func updateButtonTapped(_ sender: UIButton) {
    //뷰컨트롤러에서 전달받은 클로저를 실행한다.
    //내 자신 ToDoCell을 전달하면서! 🌟
    updateButtonPressed(self)
  }
  
}
