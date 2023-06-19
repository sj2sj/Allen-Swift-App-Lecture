//
//  MemberListManager.swift
//  MemberList
//
//  Created by 뜌딩 on 2023/06/15.
//

import UIKit

//비즈니스 모델
final class MemberListManager {
  
  private var memberList: [Member] = []
  
  func makeMemberListDatas() {
    
    memberList = [
      Member(name: "홍길동", age: 20, phone: "010-1111-2222", address: "서울"),
      Member(name: "임꺽정", age: 23, phone: "010-2222-8911", address: "서울"),
      Member(name: "스티브", age: 50, phone: "010-3333-3512", address: "미국"),
      Member(name: "쿡", age: 30, phone: "010-1252-3189", address: "캘리포니아"),
      Member(name: "베조스", age: 50, phone: "010-1567-3612", address: "하와이"),
      Member(name: "배트맨", age: 41, phone: "010-8952-2612", address: "고담시티"),
      Member(name: "조커", age: 41, phone: "010-1623-1111", address: "고담시티")
    ]
  }
  
  //전체 멤버 리스트 조회
  func getMemberList() -> [Member] {
    return memberList
  }
  
  //새로운 멤버 추가
  func makeNewMember(_ member: Member) {
    memberList.append(member)
  }
  
  //기존 멤버 정보 수정
  func updateMemberInfo(index: Int, _ member: Member) {
    memberList[index] = member
  }
  
  //특정 멤버 얻어가기
  subscript(index: Int) -> Member {
    get {
      return memberList[index]
    }
    set {
      memberList[index] = newValue
    }
  }
  
}
