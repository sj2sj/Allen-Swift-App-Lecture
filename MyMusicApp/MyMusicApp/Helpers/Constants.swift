//
//  Constants.swift
//  MyMusicApp
//
//  Created by 뜌딩 on 2023/07/13.
//

import UIKit

//MARK: -- Name Space 만들기

/* 데이터 영역에 저장 (열거형, 구조체 모두 가능 / 전역변수로도 설정 가능함) */

//사용하게 될 API 문자열 묶음
public enum MusicApi {
  static let requestUrl = "https://itunes.apple.com/search?"
  static let mediaParam = "media=music"
}

//Cell의 문자열 묶음
public struct Cell {
  static let musicCellIdentifier = "MyMusicCell"
  static let musicCollectionViewCellIdentifer = "MusicCollectionViewCell"
  private init() {} //다른 곳에서 Cell 인스턴스 생성을 못하게 하기 위해
}

//컬렉션뷰 구성을 위한 설정
public struct CVCell {
  static let spacingWidth: CGFloat = 1
  static let cellColumns: CGFloat = 3
  private init() {}
}
