import UIKit

struct MusicData: Codable {
  let resultCount: Int
  let results: [Music]
}


//서버에서 받아오는 데이터들은 대부분 옵셔널로 설정
struct Music: Codable {
  let artistName: String?
  let collectionName: String?
  let songName: String?
  let previewURL: String?
  private let releaseDate: String?

  enum CodingKeys: String, CodingKey {
    case artistName
    case collectionName
    case songName = "trackName"
    case previewURL = "previewUrl"
    case releaseDate
  }
}



//func getMethod() -> [Music]?
//위와 같은 형태는 불가!!!!!!!!!!!
//비동기 처리를 하기 때문에 결과값을 언제 받을 수 있을 지 모르기 때문에 항상 nil 던짐
//그럼, 결과값을 받으려면???? 콜백함수를 사용해야 함!!

//🌟🌟🌟🌟🌟콜백함수를 사용해야 비동기작업이 끝날 때 결과를 받을 수 있음!
func getMethod(completion: @escaping ([Music]?) -> Void) {

  // URL구조체 만들기
guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=jazz") else {
    print("Error: cannot create URL")
    completion(nil)
    return
  }

  // URL요청 생성
  var request = URLRequest(url: url)
  request.httpMethod = "GET"
  
  
  // 요청을 가지고 작업세션시작

  URLSession.shared.dataTask(with: request) { data, response, error in
    // 에러가 없어야 넘어감
    guard error == nil else {
      print("Error: error calling GET")
      print(error!)
      completion(nil)
      return
    }
    // 옵셔널 바인딩
    guard let safeData = data else {
      print("Error: Did not receive data")
      completion(nil)
      return
    }
    // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
      print("Error: HTTP request failed")
      completion(nil)
      return
    }

    do {
      let decoder = JSONDecoder()
      let musicData = try decoder.decode(MusicData.self, from: safeData)
      completion(musicData.results)
      return
    } catch {
      print(error)
    }


  }.resume()     // 시작
  print("네트워크 통신은 비동기적으로 동작하기 때문에 이 print문이 먼저 출력")
}


//🌟🌟🌟🌟🌟 사용
getMethod { musicArray in
  
  guard let array = musicArray else { return }
  dump(array)
}






