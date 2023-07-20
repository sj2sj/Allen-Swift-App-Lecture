//
//  MusicCollectionViewCell.swift
//  MyMusicApp
//
//  Created by 뜌딩 on 2023/07/19.
//

import UIKit

final class MusicCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet private weak var mainImageView: UIImageView!
  
  //이미지 URL을 전달받는 속성
  var imageUrl: String? {
    didSet {
      loadImage()
    }
  }
  
  // URL => 이미지를 세팅하는 메서드
  private func loadImage() {
    guard let urlString = self.imageUrl, let url = URL(string: urlString) else { return }
    
    //오래 걸리는 작업 동시성 처리
    DispatchQueue.global().async {
      //URL을 가지고 데이터를 만드는 메서드
      //일반적으로 이미지 가져올때 많이 사용함
      guard let data = try? Data(contentsOf: url) else { return }
      //오래걸리는 작업이 일어나고 있는 동안 url이 바뀔 가능성 제거 ⭐️⭐️⭐️⭐️
      guard self.imageUrl! == url.absoluteString else { return }
      
      //작업 결과물 표시 (메인큐)
      DispatchQueue.main.async {
        self.mainImageView.image = UIImage(data: data)
      }
    }
  }
  
  //셀 재사용 전에 호출되는 메서드
  override func prepareForReuse() {
    super.prepareForReuse()
    //이미지가 바뀌는 것 처럼 보이는 현상을 없애기 위해서 실행!! ⭐️
    self.mainImageView.image = nil
  }
  
  
}
