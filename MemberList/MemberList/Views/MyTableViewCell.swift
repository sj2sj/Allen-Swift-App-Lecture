//
//  MyTableViewCell.swift
//  MemberList
//
//  Created by 뜌딩 on 2023/06/15.
//

import UIKit

class MyTableViewCell: UITableViewCell {
  
  //속성감시자 사용해서 member가 변할 때마다 didSet 실행
  var member: Member? {
    didSet {
      guard var member = member else {return}
      mainImageView.image = member.memberImage
      memberNameLabel.text = member.name
      addressLabel.text = member.address
    }
  }
  

  //MARK: UI 구현
  
  let mainImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let memberNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let addressLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 10)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let stackView: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.distribution = .fill
    sv.alignment = .fill
    sv.spacing = 5
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    setupStackView()
  }
  
  func setupStackView() {
    self.addSubview(mainImageView)
    
    //셀 위에 스택뷰 올림
    self.addSubview(stackView)
    
    //스택뷰 위에 레이블들 올림
    stackView.addArrangedSubview(memberNameLabel)
    stackView.addArrangedSubview(addressLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  /*
  //스토리보드로 UI구현할 때 사용하는 함수
  override func awakeFromNib() {
      super.awakeFromNib()
      
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }
  */
  
  //MARK: 오토레이아웃 세팅
  override func updateConstraints() {
    setConstraints()
    super.updateConstraints()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.mainImageView.clipsToBounds = true
    self.mainImageView.layer.cornerRadius = self.mainImageView.frame.width / 2
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      mainImageView.heightAnchor.constraint(equalToConstant: 40),
      mainImageView.widthAnchor.constraint(equalToConstant: 40),
      mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      mainImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
    
    NSLayoutConstraint.activate([
      memberNameLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: self.mainImageView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: self.mainImageView.bottomAnchor)
    ])
  }
  
  

}
