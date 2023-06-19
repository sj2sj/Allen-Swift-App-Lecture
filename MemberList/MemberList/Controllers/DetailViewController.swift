//
//  DetailViewController.swift
//  MemberList
//
//  Created by 뜌딩 on 2023/06/19.
//

import UIKit

final class DetailViewController: UIViewController {
  
  private let detailView = DetailView()
  
  var member: Member?

  override func loadView() {
    view = detailView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupButtonAction()
    setupData()
  }
  
  private func setupData() {
    //데이터 전달 받음
    detailView.member = member
  }
    
  
  func setupButtonAction() {
    detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
  }

  @objc func saveButtonTapped() {
    print("버튼 눌림")
    
    if member == nil { //멤버가 없다면 (새로운 멤버 추가)
      let name = detailView.nameTextField.text ?? ""
      let age = Int(detailView.ageTextField.text ?? "")
      let phoneNumber = detailView.phoneNumberTextField.text ?? ""
      let address = detailView.addressTextField.text ?? ""
      
      var newMember = Member(name: name, age: age, phone: phoneNumber, address: address)
      newMember.memberImage = detailView.mainImageView.image
      
      /* 1️⃣ 델리게이트 아닌 방식으로 구현 */
      let index = navigationController!.viewControllers.count - 2
      let vc = navigationController?.viewControllers[index] as! ViewController
      vc.memberListManager.makeNewMember(newMember)
      
      /* 2️⃣ 델리게이트 방식 구현 */
      //delegate?.addNewMember(newMember)
    } else { //----------------------------------- 멤버가 있다면 (멤버의 내용 업데이트)
      //이미지뷰에 있는 것을 그대로 다시 멤버에 저장함
      member?.memberImage = detailView.mainImageView.image
      
      let memberId = Int(detailView.memberIdTextField.text!) ?? 0
      member!.name = detailView.nameTextField.text ?? ""
      member!.age = Int(detailView.ageTextField.text ?? "") ?? 0
      member!.phone = detailView.phoneNumberTextField.text ?? ""
      member!.address = detailView.addressTextField.text ?? ""
      
      //뷰에도 바뀐 멤버 전달 (뷰컨트롤러 -> 뷰)
      /* 1️⃣ 델리게이트 아닌 방식으로 구현 */
      let index = navigationController!.viewControllers.count - 2
      let vc = navigationController?.viewControllers[index] as! ViewController
      vc.memberListManager.updateMemberInfo(index: memberId, member!)
      
      /* 2️⃣ 델리게이트 방식 구현 */
      //delegate?.update(index: memberId, member!)
    }
    
    // 전 화면으로 돌아가기!
    self.navigationController?.popViewController(animated: true)
    
    
    
  }
    

}
