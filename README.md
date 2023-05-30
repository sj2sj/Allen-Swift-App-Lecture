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
### 네비게이션바
- 몇가지 설정으로 복잡한 기능을 쉽게 사용 가능
- 단, 제약이 많기 때문에 모든 것이 가능한 것은 아님. (상속) 커스텀으로 만들어야 할 수도 있음
- 내부적 기능은 만들고 상단바는 숨김처리 할 수도 있음
- 네비게이션 바에 들어가있는 버튼: Bar Button Item
- present와는 다름 (네비 바 - show)

<br>

### **Navigation Controller**
```
[Editor] - [Embed in] - [Navigation Controller]
```
### **Tab Bar Controller**
```
네비게이션 컨트롤러 선택 -> [Editor] - [Embed in] - [Tab Bar Controller]
```
<br>