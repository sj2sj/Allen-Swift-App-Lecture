import UIKit

struct MusicData: Codable {
  let resultCount: Int
  let results: [Music]
}


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



func getMethod() {

  // URL구조체 만들기
  guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=jazz") else {
      print("Error: cannot create URL")
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
      return
    }
    // 옵셔널 바인딩
    guard let safeData = data else {
      print("Error: Did not receive data")
      return
    }
    // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
      print("Error: HTTP request failed")
      return
    }

    do {
      let decoder = JSONDecoder()
      let musicArray = try decoder.decode(MusicData.self, from: safeData)
      dump(musicArray)
    } catch {
      print(error)
    }


  }.resume()     // 시작
  print("네트워크 통신은 비동기적으로 동작하기 때문에 이 print문이 먼저 출력")
}


getMethod()








