//
//  MovieCell.swift
//  TableView
//
//  Created by 뜌딩 on 2023/05/30.
//

import UIKit

class MovieCell: UITableViewCell {

  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var movieNameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
