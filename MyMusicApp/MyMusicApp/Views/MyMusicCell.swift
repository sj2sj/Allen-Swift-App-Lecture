//
//  MyMusicCell.swift
//  MyMusicApp
//
//  Created by 뜌딩 on 2023/07/13.
//

import UIKit

class MyMusicCell: UITableViewCell {

  @IBOutlet weak var mainImageView: UIImageView!
  
  @IBOutlet weak var songNameLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var albumNameLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  
  //이미지 URL 전달받는 속성
  var imageUrl: String? {
    didSet {
      loadImage()
    }
  }
  
  
override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

  
  // URL ===> 이미지를 셋팅하는 메서드
  private func loadImage() {
    guard let urlString = self.imageUrl, let url = URL(string: urlString)  else { return }
    
    DispatchQueue.global().async {
    
      guard let data = try? Data(contentsOf: url) else { return }
      // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
      guard urlString == url.absoluteString else { return }
      
      DispatchQueue.main.async {
          self.mainImageView.image = UIImage(data: data)
      }
    }
  }
    
}
