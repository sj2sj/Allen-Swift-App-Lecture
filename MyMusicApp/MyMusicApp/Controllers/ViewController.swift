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
  let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
  
  @IBOutlet weak var musicTableView: UITableView!
  
  //네트워크 매니저 (싱글톤 패턴으로 생성)
  var networkManager = NetworkManager.shared
  
  //음악데이터를 다루기 위해 빈 배열 생성
  var musicArrays: [Music] = []
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    setupTableView()
    setupSearchBar()
    setupDatas()
  }
  
  //서치바 설정
  func setupSearchBar() {
    self.title = "Music Search"
    navigationItem.searchController = searchController //서치 컨트롤러에 할당
    
    // 🍏 1) (단순)서치바의 사용
    //searchController.searchBar.delegate = self
    
    
    // 🍎 2) 서치(결과)컨트롤러의 사용 (복잡한 구현 가능)
    //     ==> 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
    searchController.searchResultsUpdater = self
    
    // 첫글자 대문자 설정 없애기
    searchController.searchBar.autocapitalizationType = .none
    
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




//MARK: - 🍏 (단순) 서치바 확장

extension ViewController: UISearchBarDelegate {

  // 유저가 글자를 입력하는 순간마다 호출되는 메서드
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    print(searchText)
    // 다시 빈 배열로 만들기 ⭐️
    self.musicArrays = []

    // 네트워킹 시작
    networkManager.fetchMusic(searchTerm: searchText) { result in
      switch result {
      case .success(let musicDatas):
          self.musicArrays = musicDatas
          DispatchQueue.main.async {
              self.musicTableView.reloadData()
          }
      case .failure(let error):
          print(error.localizedDescription)
      }
    }
  }

//    // 검색(Search) 버튼을 눌렀을때 호출되는 메서드
////    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
////        guard let text = searchController.searchBar.text else {
////            return
////        }
////        print(text)
////        // 다시 빈 배열로 만들기 ⭐️
////        self.musicArrays = []
////
////        // 네트워킹 시작
////        networkManager.fetchMusic(searchTerm: text) { result in
////            switch result {
////            case .success(let musicDatas):
////                self.musicArrays = musicDatas
////                DispatchQueue.main.async {
////                    self.musicTableView.reloadData()
////                }
////            case .failure(let error):
////                print(error.localizedDescription)
////            }
////        }
////        self.view.endEditing(true)
////    }
}


//MARK: -  🍎 검색하는 동안 (새로운 화면을 보여주는) 복잡한 내용 구현 가능

extension ViewController: UISearchResultsUpdating {
 // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
 func updateSearchResults(for searchController: UISearchController) {
   print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
   // 글자를 치는 순간에 다른 화면을 보여주고 싶다면 (컬렉션뷰를 보여줌)
   let vc = searchController.searchResultsController as! SearchResultViewController
   // 컬렉션뷰에 찾으려는 단어 전달
   vc.searchTerm = searchController.searchBar.text ?? ""
  }
}
 
