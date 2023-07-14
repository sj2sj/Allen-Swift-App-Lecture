//
//  ViewController.swift
//  MyMusicApp
//
//  Created by 뜌딩 on 2023/07/13.
//

import UIKit

class ViewController: UIViewController {

  // 🍏 서치 컨트롤러 생성 ===> 네비게이션 아이템에 할당
  //let searchController = UISearchController()
    
  // 🍎 서치 Results컨트롤러 ⭐️
  //let sear = UISearchController(searchResultsController: <#T##UIViewController?#>)
    
  
  @IBOutlet weak var musicTableView: UITableView!
  
  //네트워크 매니저 (싱글톤 패턴으로 생성)
  var networkManager = NetworkManager.shared
  
  //음악데이터를 다루기 위해 빈 배열 생성
  var musicArrays: [Music] = []
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
  //테이블뷰 설정
  func setupTableView() {
    musicTableView.dataSource = self
    musicTableView.delegate = self
    
    //Nib파일 사용 시, 별도의 등록 과정 필요!!!!
    musicTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
  }
  
  
  //데이터 셋업
  func setupDatas() {
    //네트워킹 시작
    
    networkManager.fetchMusic(searchTerm: "jazz") { result in
      switch result {
      case Result.success(let musicData): //연관값 꺼내기 위해
        
        self.musicArrays = musicData
        
        //네트워킹하는 코드가 비동기적으로 동작하기 때문에
        //테아블뷰를 다시 그리는 코드는 메인쓰레드로 보내줘야함
        DispatchQueue.main.async {
          self.musicTableView.reloadData()
        }
        
        
        
      case Result.failure(let error):
        print(error.localizedDescription)
      }
    }
  }


}


extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(#function)
    return self.musicArrays.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MyMusicCell
    
    cell.imageUrl = musicArrays[indexPath.row].imageUrl
    
    cell.songNameLabel.text = musicArrays[indexPath.row].songName
    cell.artistNameLabel.text = musicArrays[indexPath.row].artistName
    cell.albumNameLabel.text = musicArrays[indexPath.row].albumName
    cell.releaseDateLabel.text = musicArrays[indexPath.row].releaseDateString
    
    cell.selectionStyle = .none
    
    return cell
  }
  

  
}




extension ViewController: UITableViewDelegate {
  // 테이블뷰 셀의 높이를 유동적으로 조절하고 싶다면 구현할 수 있는 메서드
  // (musicTableView.rowHeight = 120 대신에 사용가능)
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 120
  }
  
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

}

