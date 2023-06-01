//
//  ViewController.swift
//  TableView
//
//  Created by 뜌딩 on 2023/05/30.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

  var moviesArray: [Movie] = [
    Movie(movieImage: UIImage(named: "batman.png"), movieName: "베트맨", movieDescription: "베트맨이 출연하는 영화"),
    Movie(movieImage: UIImage(named: "captain.png"), movieName: "캡틴 아메리카", movieDescription: "캡틴 아메리카의 기원. 캡틴 아메리카는 어떻게 탄생한 것일까?")
  ]
  

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
  }
  
  //몇 개의 컨텐츠를 만들면 되는지?
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  


}

