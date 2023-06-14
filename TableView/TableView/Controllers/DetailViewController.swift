//
//  DetailViewController.swift
//  TableView
//
//  Created by 뜌딩 on 2023/06/14.
//

import UIKit

class DetailViewController: UIViewController {

  
  @IBOutlet weak var mainImageView: UIImageView!
  
  @IBOutlet weak var movieNameLabel: UILabel!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  var movieData: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
  }
    

  func setupUI() {
    mainImageView.image = movieData?.movieImage
    movieNameLabel.text = movieData?.movieName
    descriptionLabel.text = movieData?.movieDescription
  }
    

}
