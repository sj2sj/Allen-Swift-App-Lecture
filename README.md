# Swift 앱 만들기 강의
- 앨런의 Swift 15가지 App만들기 강의를 보고 실습해봅니다.
- 강의를 통해 알게 된 것들을 메모해봅니다.

<br><br><br>

## (기초 1) MyFirstApp
### 버튼을 누르면 텍스트가 변경되는 앱
- 오토레이아웃 사용 시 중복된 constraints를 주지 않도록 주의할 것
- 스토리보드와 연결된 코드를 지울 땐 스토리보드에서도 연결을 끊어줘야 함!!!
- 한 화면당 화면 하나를 관리하는 코드가 존재 <br>
(ViewController 클릭 후에 inspector를 보면 어떤 파일과 연결되어 있는지 확인할 수 있음)
- **colorLiteral** 사용하려면, #colorLiteral() 까지 작성해야함
- **viewDidLoad()**: 메모리에 View Controller가 올라오면 가장 먼저 실행되는 함수
- **@IBOutlet**: Interface Builder(뷰-객체)와 연결된 Outlet <br>
코드 상 설정을 스토리보드로 전달하기 위한 것
- **@IBAction**: Interface Builder와 연결된 Action <br>
스토리보드 상 이벤트가 일어나면 어떤 함수를 호출 시킬 것인지 알려주는 것

<br><br>

## ❓ 프레임워크와 라이브러리
```
프레임워크: 개발자가 이미 만들어진 룰을 따라 작업하는 것
라이브러리: 단순 활용가능한 도구들의 집합
```

<br><br>

## (기초 2) DiceGame
### 버튼을 누르면 2개의 주사위를 굴리는 앱
- 이미지는 Assets.xcassets에 넣어서 사용!
- 배열에서 랜덤 요소 꺼내기
```swift
Array.randomElement()
```

<br><br>

## (기초 3) RPSGame
### 가위바위보 앱
- 스토리보드에서 요소마다 정렬이 필요 할  경우 stack view를 사용하면 유용함


<br><br>

## (기초 4, 5) UpDownGame
### 숫자를 입력하면 컴퓨터의 숫자보다 Up인지 Down인지 알려주는 앱 (숫자 맞히기 앱)
- 앱 실행 시 main함수부터 시작되는데, swift 프로젝트에서는 AppDelegate의 @main 어노테이션이 그런 역할을 해줌
- UIView로 선 표현도 가능
- View Controller Scence에서 요소가 상위에 존재할 수록 하위에 위치하는 것

<br><br>
<hr>
<br><br>

## 앱 활용 서론
- Xcode - [Window] - [Developer Documents] 을 통해 개발자 문서 참조 가능
- 옵셔널 벗길 때 아래와 같이도 사용 가능
```swift
guard let myNumString = numberLabel.text else { return }
guard let myNumber = Int(MyNumString) else { return }
//위의 코드를 아래와 같이 묶어서 사용
guard let myNumString = numberLabel.text
    , let myNumber = Int(MyNumString) else { return }
```

<br><br>
## 앱 만들기 원리 (웹과 앱의 비교)
웹(Web)|iOS
--|:--:
상단->아래 (왼쪽 상단이 default)|오브젝트(대부분 클래스) 배치 <br> 내부 속성, 동작이 내장됨
화면을 그리는 매커니즘과 내부 동작 매커니즘이 분리|하나의 클래스 내에 화면을 그리는 매커니즘과 동작 매커니즘이 공존
운영체제와 독립적 /<br> 브라우저 엔진에 의해 돌아감 | 운영체제와 밀접함


<br><br>
<hr>
<br><br>


## (1) FirstTimerApp
### 슬라이더로 초를 선택하고, 초가 끝나면 사운드가 울리는 앱
- viewDidLoad 함수에 기본적인 설정을 하기보다는, 따로 함수를 만들어서 설정한 후 viewDidLoad에서 호출하는 것을 권장
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    //이렇게 바로 사용하는거보다
    //maiLabel.text = "초를 선택하세요"

    //함수를 만들어서 호출하는 것을 권장함
    configureUI()
  }

  func configureUI() {
    mainLabel.text = "초를 선택하세요"
  }
```

<br>

- **🌟 timer 사용법 🌟**
```swift
weak var timer: Timer? //강한 참조 방지

timer?.invalidate() //타이머 비활성화
timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
      //1초마다 반복할 코드
}
```

<br>

- **🌟 system sound 사용법 🌟**
```swift
import AVFoundation

AudioServicesPlayAlertSound(SystemSoundID(1016))
```

<br><br>

## (2) TextFieldProject
### TextField를 사용해보는 앱
- viewController에는 view라는 속성이 존재하기 때문에 아래와 같은 설정 가능
```swift
view.backgroundColor = UIColor.gray
```

<br>

- textField 사용법 <br>
➡️ textField를 포커싱 하면 키보드가 나타나는 건 OS에서 관리하는 부분
```swift
@IBOutlet weak var textField: UITextField!

textField.keyboardType = UIKeyboardType.emailAddress 
textField.placeholder = "이메일 입력"
textField.borderStyle = .roundedRect
textField.clearButtonMode = .always
textField.returnKeyType = .next
```
- UITextFieldDelegate
```swift
/* 1️⃣ viewDidLoad 설정 */
override func viewDidLoad() {
  //...  
  textField.delegate = self //위임
  //...
}

/* 2️⃣ 델리게이트 패턴 사용 */
//텍스트 필드의 입력을 시작할때 호출되는 메서드
func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
  return true
}

//텍스트필드 입력이 시작됐을 경우 호출
//(보통 Bool이 반환타입이 아닌 경우 시점을 의미하는 경우가 많음)
func textFieldDidBeginEditing(_ textField: UITextField) {
  print("유저가 텍스트필드의 입력을 시작함")
}

//clear버튼의 동작 가능 여부
func textFieldShouldClear(_ textField: UITextField) -> Bool {
  return true
}

//텍스트필드에 글자를 입력 or 지울 때 마다 실행되는 함수
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
  print(string) //입력된 글자 출력
  return true
}

//텍스트필드의 엔터 키가 눌러질 때 호출
//(동작을 허락할 것인지? 말 것인지)
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  if textField.text == "" {
    textField.placeholder = "Type Something!"
    return false
  } else {
    return true
  }
}

//텍스트필드의 입력이 끝날 때 호출 (끝날지 말지를 허락)
func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
  return true
}

//텍스트필드의 입력이 끝났을 때 호출 (시점)
func textFieldDidEndEditing(_ textField: UITextField) {
  print("유저가 텍스트 필드의 입력을 끝냄")
}
```


- 사용 예시
```swift
//텍스트필드에 글자 입력 or 삭제 시 호출
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
  //입력되는 글자가 숫자이면 입력 허용X
  if Int(string) != nil {
    return false
  } else {
    //10글자 이상 입력 금지
    guard let text = textField.text else {return true}
    let newLength = text.count + string.count - range.length
    return newLength <= 10
  }
}
```

<br>

- 화면 탭 감지
```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  //code
}
```

<br>

- 키보드 올리기
```swift
textField.becomeFirstResponder()
```

- 키보드 내리기

```swift
textField.resignFirstResponder()
```


<br><br>

## (3) LoginProject
### 스토리보드가 아닌 코드로 UI 만들어보기 (로그인 화면)
<br>

🌟 **코드로 UI 만들기**

```swift
class ViewController: UIViewController {
  //⭐️view 속성들은 클로저 형태로 묶어서 많이 사용함! (보기 편해서)
  let emailTextFieldView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.darkGray
    view.layer.cornerRadius = 8
    view.layer.masksToBounds = true
    return view
  }()

  override func viewDidLoad() {
    //...
    makeUI()
    //...
  }

  func makeUI() {
    //내가 만든 view를 화면에 띄우기 위해서는 기존에 존재하는 view에 addSubview를 해줘야 함
    view.addSubview(emailTextFieldView)
    
    //⭐️⭐️⭐️ 오토레이아웃으로 사용하려면 반드시 false로 설정
    emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
    
    //autoLayout 설정
    emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
    emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true

    // 🫥 autoLayout 설정 시 isActive = true가 너무 귀찮아요
    // 그럼, 아래와 같이 사용 가능!!
    NSLayoutConstraint.activate([
      emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
      emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
      emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    ])
  }
}

```
<br>

- **오토레이아웃을 동적으로도 사용 가능**
```swift
lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)

emailInfoLabelCenterYConstraint.constant = -13
```

<br>

- **🌟 alert창 사용법 🌟**
```swift
let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)

let success = UIAlertAction(title: "확인", style: .default) { action in
  print("확인 버튼이 눌렸습니다.")
}

let cancel = UIAlertAction(title: "취소", style: .cancel) { cancel in
  print("취소 버튼이 눌렸습니다.")
}

//UIAlertController에 UIAlertAction 올려주기
alert.addAction(success)
alert.addAction(cancel)

//다음화면으로 넘어가는 메서드
present(alert, animated: true, completion: nil)
```




<br><br>

## (4-1) 화면 이동과 데이터 전달 실습
### 화면 이동과 데이터 전달 실습

<br>

🌟 **화면 이동 방법**

<br>
1️⃣ 코드로 화면 이동 (다음 화면이 코드로 작성되어 있을 때만 가능)

```swift
class ViewController: UIViewController {
  @IBAction func codeNextButtonTapped(_ sender: UIButton) {
    let firstVC = FirstViewController() //이동할 뷰컨트롤러
    
    firstVC.modalPresentationStyle = .fullScreen
    
    firstVC.someString = "넘겨줄 데이터"
    present(firstVC, animated: true, completion: nil)
  }
}

class FirstViewController: UIViewController {
  var someString: String? //넘겨줄 데이터 받을 변수

  //뒤로가기 버튼
  @objc func backButtonTapped() {
    dismiss(animated: true, completion: nil)
  }
}
```

<br>
2️⃣ 코드로 스토리보드 객체 생성해서 화면 이동

```swift
// 1. 스토리보드에 View Controller 올린 후 연결 할 VC 파일 생성
// 2. 스토리보드의 VC 클릭한 후 Inspector - Custom Class에서 Class에 파일로 만든 VC 이름 쓰기 (연결)
// 3. Inspector - Identity - StroyBoard ID에 withIdentifier 이름 적어주기
class ViewController: UIViewController {
  @IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {
    if let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController {
      secondVC.someString = "전달 데이터"
      
      //secondVC.mainLabel.text = "hihi" <- 이렇게 전달은 불가능

      present(secondVC, animated: true, completion: nil)
    }
  }
}

class SecondViewController: UIViewController {
  var someString: String? //넘겨줄 데이터 받을 변수

  //뒤로가기 버튼
  @objc func backButtonTapped() {
    dismiss(animated: true, completion: nil)
  }
}
```

<br>
3️⃣ 스토리보드에서의 화면 이동 (간접 세그웨이)

```swift
// 1. 스토리보드에서 View Controller 를 ctrl 누른 상태로 드래그 -> 화면 전환 할 VC에 놓기
// 2. 그럼 화살표가 연결 되는데, 이를 Segue라고 함
// 3. 스토리보드의 Segue를 선택한 후 Storyboard Segue - Identifier에 이름 작성
class ViewController: UIViewController {
  @IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
    performSegue(withIdentifier: "toThirdVC", sender: self)
  }

  //performSegue 실행시 prepare 메서드 호출됨
  //그래서 prepard 메서드에서 데이터 전달
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toThirdVC" {
      let thirdVC = segue.destination as! ThirdViewController
      
      //데이터 전달
      thirdVC.someString = "hi!"
    }
  }
}

class ThirdViewController: UIViewController {
  var someString: String? //넘겨줄 데이터 받을 변수

  //뒤로가기 버튼
  @objc func backButtonTapped() {
    dismiss(animated: true, completion: nil)
  }
}
```

<br>
4️⃣ 스토리보드에서의 화면 이동 (직접 세그웨이) <br>
// 버튼에 직접 연결

```swift
class ViewController: UIViewController {
  //버튼에 직접 세그를 연결하기 때문에 performSegue 메서드의 호출이 필요 X
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toFourthVC" {
      let fourthVC = segue.destination as! FourthViewController
      
      //데이터 전달
      fourthVC.someString = "hello"
    }
  }

  var num = 3
  // 직접 세그웨이에서만 실행됨, 화면 전환 시 조건 설정 가능
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    if num > 5 {
      return false //화면 전환 X
    } else {
      return true
    }
  }
}

class FourthViewController: UIViewController {
  var someString: String? //넘겨줄 데이터 받을 변수

  //뒤로가기 버튼
  @objc func backButtonTapped() {
    dismiss(animated: true, completion: nil)
  }
}
```

<br>
<br>

❓ **viewDidLoad**
```
스토리보드와 코드가 메모리에 올라간 후, 올라간 스토리보드와 코드들이 연결된 후에 호출됨
```


<br><br>

## (4-2) BMI
### BMI 계산기
<br>

❓ **Constrain to margins 설정**
```

```

<br>

<br><br>

## (5) 디자인패턴 
### 디자인 패턴 (이론)
<br>

❓ **디자인 패턴**
```
공통의 문제에 검증된 정형화된 해결책 (개발 패턴)
건축 ex) 건축 공법
앱 아키텍처
 ex. MVC, MVVM, MVP...
```

💡 **MVC 패턴**
```
Model - View - Controller 디자인 패턴
- Model: 비즈니스 로직 (화면과 관련 없는 로직, 데이터 관련)
- View: UI 관련, 화면 (스토리보드)
- Controller: 뷰컨트롤러, Model의 정보를 어떻게 View에 표시할 것인지? Model-View의 중재자 역할
```

<br><br>

## (참고) 앱의 내부 매커니즘
### **1. 뷰컨트롤러 생명주기 (Life Cycle)**
```
- 하나의 앱에서 화면 전환 시점을 파악

ex) 인스타그램 디테일 화면에서 좋아요 누른 후에 다시 메인화면으로 왔을 때, 좋아요 업데이트한 화면을 보여줘야함
```
❗️ 이론적 접근보다는 많이 사용해보면서 익히기
- viewDidLoad: 앱 화면에 들어오면 가장 먼저 실행 (뷰가 생성되었을 때 한번만 호출)
- viewWillApeear: 뷰가 화면에 나타날 때마다 계속 호출 (실제 스크린에 뷰가 나타나기 전에 호출)
- viewDidAppear: 실제 스크린에 뷰가 나타난 후에 호출
- viewWillDisappear: 실제 스크린에 뷰가 사라지기 전에 호출 
- viewDidDisappear: 실제 스크린에 뷰가 사라진 후에 호출

<br>

🌟 **ViewController에서 기본 view를 변경하고 싶을 때 (코드로 UI 짰을 때)**

```swift
final class ViewController: UIViewController {
  private let loginView = LoginView()

  override func loadView() {
    //super.loadView() //super 호출 X
    view = loginView
  }
}
```

<br>

### **2. 앱의 생명주기**
```
- 앱의 비활성화/ (다른 앱 또는 백그라운드) 전환/ 종료 시점 파악

ex) 앱 게임 중 -> 전화 옴 -> 앱은 자동으로 통화화면으로 전환 
(실행중이던 게임 앱: 비활성화 상태)
```

1️⃣  AppDelegate
- Not running: 앱 실행 전
- Suspended: 대기 상태

2️⃣ SceneDelegate: iOS 13부터 등장 (씬의 전환)
- Inactive
- Active
- Background running


<br>

### **3. Drawing 주기** 복습필요🫥
```
- 하나의 화면에서, (애니메이션 등) 다시 그리는 시점 파악

ex) 애니메이션과 같은 효과, 또는 스크롤 같이 화면이 이동할 때
```

<br>
<br><br>

## (6) 네비게이션바 + 탭바
### **네비게이션바**
- 몇가지 설정으로 복잡한 기능을 쉽게 사용 가능
- 단, 제약이 많기 때문에 모든 것이 가능한 것은 아님. (상속) 커스텀으로 만들어야 할 수도 있음
- 내부적 기능은 만들고 상단바는 숨김처리 할 수도 있음
- 네비게이션 바에 들어가있는 버튼: Bar Button Item
- present와는 다름 (네비 바 - show) 정확하게는 push(present) -> pop(dismiss) 
 >> 🌟 show가 pushViewController를 포함한 개념 <br> 
 >> 🌟 아이폰처럼 화면이 작으면 push처럼 동작하고 아이패드같이 큰 화면에서 show를 사용하면 화면 분할

<br>

### **Navigation Controller**
```
[Editor] - [Embed in] - [Navigation Controller]
```

<br><br>

### **탭바**
- 일반적으로 탭바는 5개가 권장(?), 애플이 기본적으로 제공해주는 것도 5개까지
- 스토리보드 설정과, 코드로만 UI를 짰을 때는 설정이 다를 수 있으므로 유의 (코드로 UI만들 때 - Scene Delegate ...)

<br>


### **Tab Bar Controller**
```
네비게이션 컨트롤러 선택 -> [Editor] - [Embed in] - [Tab Bar Controller]
```

<br>

<br>
<br><br>

## (7) 테이블 뷰 + 화면 이동 (코드로 구현 파일도 볼 것)
### **테이블 뷰**
- 세로로만 스크롤 가능한 뷰 (ex. 카카오톡 채팅 목록/채팅방 대화, 음악 앱 음악 목록, 인스타그램 피드 ... 등등)
- 테이블 뷰 내부에 셀 존재
- 델리게이트 패턴 사용 (2가지) dataSource / delegate
```
1️⃣ dataSource
실제 테이블 뷰의 표현(구성)을 위한 패턴

2️⃣ Delegate
테이블 뷰에서 어떤 행동이 일어났을 때 (스크롤, 클릭, 등등)
```
- 셀끼리 그룹화도 가능
- 유사한 형태로 컬렉션 뷰도 존재함
- 코드로 구현할 시 반드시 register 과정을 거쳐야 dequeueReusableCell 가능

<br>

🌟 TableView 사용 -> UITableViewDataSource 프로토콜 채택
(관습적으로, 프로토콜 채택은 확장에서 많이 함!!)
```swift
class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    //델리게이트 패턴 대리자 설정
    tableView.dataSource = self
    tableView.delegate = self

  }

}

extension ViewController: UITableViewDataSource {
  /* UITableViewDataSource을 채택하면 반드시 구현해야하는 메서드 (2개) */
  // 1) 테이블뷰에 몇 개의 데이터를 표시할 것인지 (셀이 몇개인지) 뷰컨트롤러에 물어봄
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  // 2) 셀의 구성 (셀에 표시하고자 하는 데이터 표시) 를 뷰컨트롤러에 물어봄
  // 테이블 뷰 스크롤 할 때마다 호출됨
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //indexPath.section //그룹
    //indexPath.row //행

    //공식처럼 쓰는 cell 뽑아오는 방법!
    //코드로 테이블뷰를 만들었으면 등록하는 과정도 필요
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
    
    return UITableViewCell()
  }
}

extension ViewController: UITableViewDelegate {
  
  //테이블 뷰 위의 셀이 클릭 되었을 때
  //indexPath: 몇 번째 행이 선택 됐는지?
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //segue의 identifier
    performSegue(withIdentifier: "toDetail", sender: indexPath)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDetail" {
      let detailVC = segue.destination as! DetailViewController
      
      let array = movieDataManager.getMovieData()
      
      //performSegue sender로 받아온 데이터
      let indexPath = sender as! IndexPath
      
      detailVC.movieData = array[indexPath.row] //우리가 전달하기 원하는 영화 데이터
    }
  }
  
}
```



<br>

<br>
<br><br>

## (8) 커스텀 델리게이트 패턴 활용
### 테이블뷰 + 네비게이션바 + 텍스트필드
### 커스텀 델리게이트 (어떤 경우에 델리게이트 패턴을 직접 만들지?)
### Notification 사용 (키보드가 올라오면 뷰 이동시키기)
### 터치가능한 이미지뷰 - 제스쳐 사용!
### 피커뷰 사용 (델리게이트 패턴): 사진첩에서 사진 가져와서 사용하기

<br>

#### **네비게이션 컨트롤러 - 코드로 UI 구성할 때**
SceneDelegate 파일
```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
/* ------------------------------ */
  guard let windowScene = (scene as? UIWindowScene) else { return }
  window = UIWindow(windowScene: windowScene)
  
  let naviVC = UINavigationController(rootViewController: ViewController())
  
  window?.rootViewController = naviVC
  window?.makeKeyAndVisible()
/* ------------------------------ */
}
```

<br>

🌟 present 메서드는 ViewController에서만 가능하기 때문에 다음 화면으로 넘어가는 이벤트는 항상 ViewController에서!!!! (view에서는 X)

<br>

🌟 viewWillAppear
```swift
  //다른화면 갔다가 다시 돌아왔을 때 실행
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    //테이블 뷰 리로드
    tableView.reloadData()
  }
```

<br>

🌟 info.plist 설정
```
앱의 기본 설정 관련 내용이 저장
앱 실행 시, 해당 설정이 불러와지는 개념임

Information Property List
 * Privacy 등의 설정 가능 (카메라, 사진첩 등 권한 설정)
```

<br>

🌟 **Notification**
<br>
애플리케이션 내에서 정보 전달을 위한 알림

```swift
class DetailView: UIView {
  //view에서 노티피케이션 등록
  override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = .white
      setupNotification()
    }

  func setupNotification() {
    // 노티피케이션의 등록 ⭐️
    // (OS차원에서 어떤 노티피케이션이 발생하는지 이미 정해져 있음)
    // 키보드 올라왔을 때 moveUpAction 메서드 실행
    NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
    // 키보드 내려갔을 때 moveDownAction 메서드 실행
    NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  //소멸자
  deinit {
    // 노티피케이션의 등록 해제 (해제안하면 계속 등록될 수 있음) ⭐️
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
}
```

<br>

❓ Notification과 델리게이트 패턴의 차이
- Notifcation (1:N의 개념) 단방향 (리턴 개념 X)
- 델리게이트 패턴 (1:1의 개념) 쌍방향

<br>

<br>
<br><br>

## (참고) 네트워킹
### <클라이언트(앱, 웹) --- TCP/IP --- 서버>

### **TCP/IP : 인터넷에 관련된 다양한 프로토콜의 집합 (HTTP, IP, TCP, UDP, ...)**

<br>

### **⭐️ HTTP**(HyperText Transfer Protocol): 인터넷의 모든 것은 HTTP로 구성
- HTTP 0.9, 1.0 ...
- HTTP 1.1: 1997.1 ~ 2014 / 현재도 여전히 사용하고 있는 버전

<br>

### **🌟 HTTP 메세지 형태**
1️⃣ HTTP 요청 메시지 (Request)
```
①시작라인 (메소드 + 요청대상(경로) + HTTP 버전)
POST /form/entry HTTP /1.1 
②header (모든 부가정보)
Host: www.~~~~.com
Connection: Keep-alive
Content-Type: application/x-www-form-urlencoded
Content-Length: 10
③공백라인

④Message Body (실제 전송 데이터 -- JSON, HTML문서, 이미지, 영상 등)
name=gidong&age=20
```

2️⃣ HTTP 응답 메시지 (Response)
```
①시작라인 (HTTP 버전 + 상태코드 + 상태코드에 대한 문구)
HTTP /1.1 200 OK
②header (모든 부가정보)
Date: Tue, 10 Jul 2020 06:40:14 GMT
Content-Length: 352
Content-Type: text/html
③공백라인

④Message Body (실제 전송 데이터 -- JSON, HTML문서, 이미지, 영상 등)
<html>
......
```

<br>

### **🌟 HTTP 프로토콜 / 요청 메서드 종류**
 CRUD (Create - Read - Update - Delete) 

메서드|설명|예시
--|:--|:--
GET | 리소스 취득 (조회) | 게시판 글 읽어오기
POST | 엔티티 (등록) | 게시판 글 쓰기, 댓글 달기, 새로운 주문 생성
PUT | 파일 전송 (데이터 대체, 없으면 생성) | 게시글 수정 (데이터 전부 대체)
DELETE | 파일 삭제 | 게시물 삭제
PATCH | 리소스 부분 변경 | 게시글에 좋아요

<br>

### **🌟 HTTP 프로토콜 / 응답 상태 코드**
상태 코드|클래스|설명
--|:--|:--
1xx|informational|리퀘스트를 받아들여 처리중 (거의 사용 X)
2xx|Success|리퀘스트 정상 처리함
3xx|Redirection|리퀘스트 완료를 위해 추가 동작 필요
4xx|Client Error|잘못된 요청
5xx|Server Error|서버의 리퀘스트 처리 실패 (서버 에러)


<br> <br>

### **⭐️ URL query**
https://www.~~~.com:443/search?q=swift&hl=ko
- 443: port
- ?q=swift&hl=ko: 쿼리 파라미터
  - key=value 형태
  - ?로 시작하고 &로 파라미터 추가
  
<br>

**쿼리 파라미터를 통한 데이터 전송**
- GET 메서드
- (ex) 검색어 / 정렬 기준 등

**메시지 바디를 통한 데이터 전송**
- POST / PUT / PATCH 메서드
- (ex) 회원가입 / 게시글 작성, 수정 등

<br> <br>

### **⭐️ REST API**
- 클라이언트와 서버 사이의 요청 방식에 대한 약속
- 과거에는, 요청을 보낼 때 https://(사이트주소)/1 이런 식으로 요청함 ➡️ 어떤 요청을 한건지 개발자가 구분하기 어려움
- 현재에서는 REST한 형식의 API를 채택하여 https://(사이트주소)/movielist 등의 명사 형태로 요청을 보냄

<br> <br>

### **⭐️ iOS 데이터 요청 4단계**
요청이 있어야 응답이 존재함 
1. URL (문자열로 URL 생성)
2. URL Session 
3. dataTask
4. 시작(resume)

받아온 데이터를 JSON Parsing하여 우리가 사용할 수 있는 Class/Struct 형태로 만들어서 사용

> 👉 요청 코드는 네트워킹 교재 20-1-1 참고!

<br>

### **🌟 데이터 변환 프로토콜**
Codable <br>
Decodable: 데이터 -> 클래스, 구조체 <br>
Encodable: 클래스, 구조체 -> 데이터

<br>
<br><br>

## (참고) 비동기 프로그래밍에 대한 이해

###  **1️⃣ 비동기(Async) VS 동기(Sync)**
#### **비동기**
task를 queue에 보냄 --> 즉시 return
(작업이 끝나는 것을 기다리지 않고 바로 Main Thread로 돌아감)

<br>

#### **동기**
task가 끝날 때까지 기다림

<br>
👉 swift에서는 동기: Blocking, 비동기: Non-blocking으로만 동작

<br> 

###  **2️⃣ 직렬(Serial) VS 동시(Concurrent)**
#### **직렬**
- 분산처리 시킨 작업을 한 개의 Thread에서 처리
- 순서가 중요한 작업을 처리

<br>

#### **동시**
- 다른 여러 개의 쓰레드에서 처리
- 독립적이지만 유사한 여러개의 작업들을 처리

<br>

```swift
DispatchQueue.global().async {
  //비동기 처리 할 코드들
  //단, 내부적으로는 동기적으로 작동!!!!
}


/*-----------밑의 코드와----------*/
DispatchQueue.global().async {
  //test1() 실행 후 test2() 실행
  test1()
  test2()
}

//밑의 코드는 다름!!!!!
DispatchQueue.global().async {
  test1()
}
DispatchQueue.global().async {
  test2()
}
/*------------------------------*/
```


<br> 

###  **3️⃣ GCD의 개념 및 종류**
#### **내용 보강 필요 / 문법-176강~**

URLSession은 내부적

<br> 

###  **4️⃣ GCD 사용시 주의해야할 점**
#### (1) 반드시 메인큐에서 처리해야하는 작업
* UI 작업은 반드시 메인큐에서 처리해야 함 
(DispatchQueue.main.async {})

<br>

** URLSession은 내부적으로 비동기 동작

<br>

### **🌟🌟🌟 컴플리션 핸들러의 존재 이유 🌟🌟🌟**
> 비동기 작업에서 return을 통해 데이터 전달을 하려고 하면 항상 nil을 반환함 -> 클로저 호출해서 데이터 전달해야함!! <br>
⚠️ 비동기 작업은, 콜백함수를 통해 끝나는 시점을 알려줘야함

<br>
<br><br>

## (참고) Siwft에서의 날짜와 시간 다루기
### 


<br>
<br><br>





## (9) 음악 검색 앱
### 테이블뷰 + 네트워킹 + 서치컨트롤러(서치바) + 간단한 컬렉션 뷰를 이용하여 음악 검색 앱 구현
### 네트워킹을 담당하는 객체 만들기 (일반적으로 싱글톤 패턴으로 구성) 
- 가져온 데이터를 우리가 사용하려는 구조체/클래스 등의 배열로 변환
### 서치컨트롤러(서치바)를 통해 검색 기능 구현
- 검색 단어를 입력하는 동안 새로운 뷰컨트롤러를 보여주는 방법도 구현 - searchResults
### 컬렉션 뷰 - 2가지 델리게이트 패턴 (datasource / delegate) 
- 단, 컬렉션 뷰 자체의 레이아웃을 담당하는 객체가 따로 존재
### UICollectionViewFlowLayOut
- 셀의 크기, 셀 간격, 스크롤 방향 등 담당 (컬렉션과 관련된 모든 형태)
### Nib(Xib)의 사용법
- 스토리보드와 분리해서 뷰의 화면 구성 가능
### 간단한 Name Space 사용법 
- identifier 등 문자열 등을 실수하지 않기 위한 패턴


<br>

#### **🌟🌟 셀(Cell)에서의 이미지 표현 🌟🌟**
> Cell은 재사용되기 때문에 이미지를 받아오는 일처럼 오래걸리는 일 (비동기적)을 Cell 내부에서 해야함 <br> * 앱 81강 참조!!!!


<br>

#### **✓ Collection View 사용**
> 컬렉션 뷰에는 레이아웃을 담당하는 객체가 따로 존재

```swift
//컬렉션뷰와 연결
@IBOutlet weak var collectionView: UICollectionView!

// 컬렉션뷰의 레이아웃을 담당하는 객체
let flowLayout = UICollectionViewFlowLayout()

func setupCollectionView() {
  //...flowLayout으로 레이아웃 설정...//
  //컬렉션 뷰 속성에 할당 🌟
  collectionView.collectionViewLayout = flowLayout
}
```

<br>



<br>

#### **✓ Nib 파일 생성 (UITableViewCell)**
> Cell을 직접적으로 스토리보드에 올리지 않고 따로 떼서 만들고 싶을 때 사용

1. [New File] - [Cocoa Touch Class]
2. SubClass of: UITableViewCell
3. ☑ Also create XIB file *현재는 Nib 파일을 사용  
  -> swift파일과 스토리보드처럼 생긴 녀석이 같이 생성됨


<br>

#### **✓ Name Space**
> 공통으로 사용되는 url 등을 따로 파일로 빼서 사용

1. Helpers 폴더 생성 - Constants 파일 (폴더/파일명은 자유)
```swift

```

<br>

<br>
<br><br>





## (10) TO-DO APP
### 코어데이터(앱이 꺼져도 데이터를 저장하는 프레임워크)의 사용
- **코어데이터**: 앱이 꺼져도 데이터를 (엑셀과 같은 형태로) 구성해서 저장할 수 있는, 애플이 만들어 놓은 프레임워크
### 로컬 저장소에 데이터를 저장 / 읽어오기 / 수정 / 삭제해서 표시
### 커스텀 델리게이트 패턴 사용
- 셀 자체가 아닌, 셀 위에 있는 버튼이 눌리는 것을 구현
### 클로저의 활용
- 셀 위의 버튼이 눌렸을 때 뷰 컨트롤러에 동작을 전달하도록 구현
- 셀 위에 존재하는 버튼 동작(touchUpInside) -> 뷰컨트롤러에 정의한 클로저 실행


<br>

#### **✓ 코어데이터 사용을 위한 설정**
1. 프로젝트 생성 ->  ☑ Use Core Data
2. xcdatamodeld 파일에서 Add Entity로 데이터 생성
3. Attribute, Type 설정
 <br>

> ❓ 파일로 데이터를 보고 싶다면
> 1) ENTITY - Codegen - Manual/None 선택 <br>
> 2) [Editor] - [Create NSManagedObject Subclass...ß]