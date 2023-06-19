//
//  ViewController.swift
//  MemberList
//
//  Created by 뜌딩 on 2023/06/15.
//

import UIKit

final class ViewController: UIViewController {
  
  //테이블 뷰 생성
  //테이블 뷰를 만들 땐 굳이 뷰를 분리할 필요X -> 셀이 뷰의 역할을 해줌, 셀만 따로 구현
  private let tableView = UITableView()
  
  var memberListManager = MemberListManager()

  //네비게이션에 넣기 위한 버튼
  lazy var plusButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
    return button
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupDatas()
    setupTableView()

    setupNaviBar()
    setupTableViewConstraints()
  }
  
  
  //다른화면 갔다가 다시 돌아왔을 때~
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }

  
  //네비게이션 바 설정
  func setupNaviBar() {
    title = "화면 목록"
    
    //네비게이션 설정 관련 소스
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .white
    navigationController?.navigationBar.tintColor = .systemBlue
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    //네비게이션 오른쪽 상단의 버튼 설정 소스
    self.navigationItem.rightBarButtonItem = self.plusButton
  }
  
  
  func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.rowHeight = 60
    
    tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
  }
  
  //데이터 셋업
  func setupDatas() {
    memberListManager.makeMemberListDatas() //(일반적으로) 서버에 요청하는 데이터
  }
  
  
  
  //테이블 뷰 오토레이아웃 설정
  func setupTableViewConstraints() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
    ])
  }
  
  
  //플러스 버튼 (멤버 추가 화면으로~)
  @objc func plusButtonTapped() {
    let detailVC = DetailViewController()
    
    navigationController?.pushViewController(detailVC, animated: true)
  }

}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return memberListManager.getMemberList().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MyTableViewCell
    
    //subscript 구현되어있기 때문에 이렇게 사용 가능
    /* cell.mainImageView.image = memberListManager[indexPath.row].memberImage
    cell.memberNameLabel.text = memberListManager[indexPath.row].name
    cell.addressLabel.text = memberListManager[indexPath.row].address */
    
    cell.member = memberListManager[indexPath.row]
    cell.selectionStyle = .none
    
    return cell
  }

}


extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //다음화면으로 넘어가게
    let detailVC = DetailViewController()
    
    let array = memberListManager.getMemberList()
    detailVC.member = array[indexPath.row]
    
    navigationController?.pushViewController(detailVC, animated: true)
    
  }
  
}
