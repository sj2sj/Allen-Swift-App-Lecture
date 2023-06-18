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

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupDatas()
    setupTableView()

    setupNaviBar()
    setupTableViewConstraints()
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
    //self.navigationItem.rightBarButtonItem = self.plusButton
  }
  
  
  func setupTableView() {
    tableView.dataSource = self
    
    tableView.rowHeight = 60
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

}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return memberListManager.getMemberList().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return UITableViewCell()
  }

}
