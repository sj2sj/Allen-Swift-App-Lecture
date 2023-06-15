//
//  ViewController.swift
//  TableView
//
//  Created by 뜌딩 on 2023/05/30.
//

import UIKit

class ViewController: UIViewController {

 // var moviesArray: [Movie] = []
  
  var movieDataManager = DataManager()
  

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.rowHeight = 120
    
    tableView.delegate = self
    
    self.title = "영화목록"
    
    movieDataManager.makeMovieData()
    //moviesArray = movieDataManager.getMovieData()
  }
  
  

  @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {

    movieDataManager.updateMovieData()

    
    tableView.reloadData()
  }
  

}


extension ViewController: UITableViewDataSource {
  //몇 개의 컨텐츠를 만들면 되는지?
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(#function)
    return movieDataManager.getMovieData().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print(#function)
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
    
    let movie = movieDataManager.getMovieData()[indexPath.row]
    
    cell.mainImageView.image = movie.movieImage
    cell.movieNameLabel.text = movie.movieName //아래와 동일
    cell.descriptionLabel.text = movie.movieDescription
    cell.selectionStyle = .none
    
    return cell
  }
}



extension ViewController: UITableViewDelegate {
  
  //테이블 뷰 위의 셀이 클릭 되었을 때
  //indexPath: 몇 번째 행이 선택 됐는지?
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    performSegue(withIdentifier: "toDetail", sender: indexPath)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDetail" {
      let detailVC = segue.destination as! DetailViewController
      
      let array = movieDataManager.getMovieData()
      
      let indexPath = sender as! IndexPath
      
      detailVC.movieData = array[indexPath.row] //우리가 전달하기 원하는 영화 데이터
    }
  }
  
}
