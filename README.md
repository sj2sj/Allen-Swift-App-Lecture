# Swift 앱 만들기 강의
- 앨런의 Swift 15가지 App만들기 강의를 보고 실습해봅니다.
- 강의를 통해 알게 된 것들을 메모해봅니다.

<br><br><br>

## (1) MyFirstApp
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

<br><br><br>
