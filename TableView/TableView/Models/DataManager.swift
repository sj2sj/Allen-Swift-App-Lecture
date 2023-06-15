//
//  DataManager.swift
//  TableView
//
//  Created by 뜌딩 on 2023/06/09.
//

import UIKit

class DataManager {
  var movieDataArray: [Movie] = []
  
  func makeMovieData() {
    movieDataArray = [
      Movie(movieImage: UIImage(named: "batman.png"), movieName: "베트맨", movieDescription: "베트맨이 출연하는 영화"),
      Movie(movieImage: UIImage(named: "captain.png"), movieName: "캡틴 아메리카", movieDescription: "캡틴 아메리카의 기원. 캡틴 아메리카는 어떻게 탄생한 것일까?"),
      Movie(movieImage: UIImage(named: "thor.png"), movieName: "토르", movieDescription: "토르"),
      Movie(movieImage: UIImage(named: "hulk.png"), movieName: "헐크", movieDescription: "헐크"),
      Movie(movieImage: UIImage(named: "spiderman.png"), movieName: "스파이더맨", movieDescription: "스파이더맨"),
      Movie(movieImage: UIImage(named: "blackpanther.png"), movieName: "블랙 팬서", movieDescription: "블랙 팬서"),
      Movie(movieImage: UIImage(named: "doctorstrange.png"), movieName: "닥터 스트레인지", movieDescription: "외과 의사 닥터 스트레인지가 히어로가 되는 과정을 담은 영화"),
      Movie(movieImage: UIImage(named: "guardians.png"), movieName: "가디언즈 오브 갤럭시", movieDescription: "빌런 타노스에 맞서서 세상을 지키려는 가디언즈 오브 갤럭시 멤버들")
    ]
  }
  
  func getMovieData() -> [Movie] {
    return movieDataArray
  }
  
  func updateMovieData() {
    let movie = Movie(movieImage: UIImage(named: "spiderman2.png"), movieName: "스파이더맨2", movieDescription: "스파이더맨 시즌2")
    movieDataArray.append(movie)

  }
  
}
