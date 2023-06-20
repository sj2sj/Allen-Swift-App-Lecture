//
//  Member.swift
//  MemberList
//
//  Created by 뜌딩 on 2023/06/15.
//

import UIKit

//커스텀 델리게이트 패턴
//실제로 일이 일어나는 곳은 DetailViewController이지만 행동은 ViewController가 해줘야함 (대리자)
protocol MemberDelegate: AnyObject { //Class에서만 채택 가능하게 만들기 위해 AnyObject 상속
  //새로운 멤버 추가
  func addNewMember(_ member: Member)
  //멤버 업데이트
  func update(index: Int, _ member: Member)
}


//데이터 모델
struct Member {
  
  //이미지가 없을 수도 있기 때문에 메모리낭비 하지 않기 위해서 지연저장속성 사용
  lazy var memberImage: UIImage? = {
    //이름 없다면, 시스템 사람 이미지 세팅
    guard let name = name else {
      return UIImage(systemName: "person")
    }
    //해당 이름으로 된 이미지가 없다면, 시스템 사람 이미지 세팅
    return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
  }()
  
  // 타입저장속성 - 멤버의 절대적 순서를 위한 속성 (누적을 위해)
  static var memberNumbers: Int = 0
  
  let memberId: Int
  var name: String?
  var age: Int?
  var phone: String?
  var address: String?
  
  
  //생성자
  init(name: String?, age: Int?, phone: String?, address: String?) {
    
    //memberId에 순번
    self.memberId = Member.memberNumbers
    
    self.name = name
    self.age = age
    self.phone = phone
    self.address = address
    
    //멤버 생성 후 멤버번호 +1
    Member.memberNumbers += 1
  }
  
}
