//
//  ViewController.swift
//  TableView
//
//  Created by 뜌딩 on 2023/05/30.
//

import UIKit

class ViewController: UIViewController {

  var moviesArray: [Movie] = []
  
  var movieDataManager = DataManager()
  

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.rowHeight = 120
    
    movieDataManager.makeMovieData()
    moviesArray = movieDataManager.getMovieData()
  }
  
  


}


extension ViewController: UITableViewDataSource {
  //몇 개의 컨텐츠를 만들면 되는지?
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(#function)
    return moviesArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print(#function)
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
    
    let movie = moviesArray[indexPath.row]
    
    cell.mainImageView.image = movie.movieImage
    cell.movieNameLabel.text = movie.movieName //아래와 동일
    cell.descriptionLabel.text = moviesArray[indexPath.row].movieDescription
    //cell.selectionStyle = .none
    
    return cell
  }
}
