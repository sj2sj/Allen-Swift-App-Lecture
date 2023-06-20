//
//  DetailViewController.swift
//  MemberList
//
//  Created by 뜌딩 on 2023/06/19.
//

import UIKit
import PhotosUI

final class DetailViewController: UIViewController {
  
  private let detailView = DetailView()
  
  //강한 순환 참조 방지
  //프로토콜을 weak var로 선언하려면 해당 프로토콜이 AnyObject를 상속받아야함
  weak var delegate: MemberDelegate?
  
  var member: Member?

  override func loadView() {
    view = detailView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupButtonAction()
    setupData()
    setupTapGestures()
  }
  
  private func setupData() {
    //데이터 전달 받음
    detailView.member = member
  }
    
  
  //뷰에 있는 버튼 타겟 설정
  func setupButtonAction() {
    detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
  }
  
  //MARK: - 이미지 뷰가 눌렸을 때 동작 설정
  
  //제스처 설정 (이미지 뷰 눌리면 실행)
  func setupTapGestures() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
    detailView.mainImageView.addGestureRecognizer(tapGesture)
    detailView.mainImageView.isUserInteractionEnabled = true
  }
  
  @objc func touchUpImageView() {
    print("이미지 뷰 터치")
    //기본설정
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = 1
    configuration.filter = .any(of: [.images, .videos])
    
    //기본설정으로 피커뷰 컨트롤러를 생성
    let picker = PHPickerViewController(configuration: configuration)
    
    //피커뷰 컨트롤러 대리자 설정
    picker.delegate = self
    
    //피커뷰 띄움
    self.present(picker, animated: true, completion: nil)
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
//      let index = navigationController!.viewControllers.count - 2
//      let vc = navigationController?.viewControllers[index] as! ViewController
//      vc.memberListManager.makeNewMember(newMember)
      
      /* 2️⃣ 델리게이트 방식 구현 */
      delegate?.addNewMember(newMember)
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
//      let index = navigationController!.viewControllers.count - 2
//      let vc = navigationController?.viewControllers[index] as! ViewController
//      vc.memberListManager.updateMemberInfo(index: memberId, member!)
      
      /* 2️⃣ 델리게이트 방식 구현 */
      delegate?.update(index: memberId, member!)
    }
    
    // 전 화면으로 돌아가기!
    self.navigationController?.popViewController(animated: true)
    
    
    
  }
    

}


//MARK: - 피커뷰 델리게이트 설정

extension DetailViewController: PHPickerViewControllerDelegate {
    
    // 사진이 선택이 된 후에 호출되는 메서드
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // 피커뷰 dismiss
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    // 이미지뷰에 표시
                    self.detailView.mainImageView.image = image as? UIImage
                }
            }
        } else {
            print("이미지 못 불러왔음!!!!")
        }
    }
}
