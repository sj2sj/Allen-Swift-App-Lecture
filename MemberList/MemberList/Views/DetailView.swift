//
//  DetailView.swift
//  MemberList
//
//  Created by 뜌딩 on 2023/06/19.
//

import UIKit

class DetailView: UIView {

  var member: Member? {
    didSet {
      guard var member = member else {
        //멤버가 없을 시 (새로운 멤버 추가 창)
        //멤버 없으면 버튼 텍스트를 "SAVE"로
        saveButton.setTitle("SAVE", for: .normal)
        //멤버 없으면 타입 저장 속성의 현재 숫자 가져오기
        memberIdTextField.text = "\(Member.memberNumbers)"
        return
      }
      //멤버 있으면
      mainImageView.image = member.memberImage
      memberIdTextField.text = "\(member.memberId)"
      nameTextField.text = member.phone
      phoneNumberTextField.text = member.phone
      addressTextField.text = member.address
      
//      guard let age = member.age else {
//        ageTextField.text = ""
//        return
//      }
//      ageTextField.text = "\(age)"
      
      //나이
      ageTextField.text = member.age != nil ? "\(member.age!)" : ""
    }
  }
  
  
  
  //MARK: - UI구현
  
  let mainImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .lightGray
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 75
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  // 정렬 깔끔하게 하기 위한 컨테이너 뷰
  lazy var imageContainView: UIView = {
    let view = UIView()
    view.addSubview(mainImageView)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let memberIdLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.text = "멤버번호:"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let memberIdTextField: UITextField = {
    let tf = UITextField()
    tf.frame.size.height = 22
    tf.textColor = .black
    tf.borderStyle = .roundedRect
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.clearsOnBeginEditing = false
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  lazy var memberIdStackView: UIStackView = {
    let stview = UIStackView(arrangedSubviews: [memberIdLabel, memberIdTextField])
    stview.spacing = 5
    stview.axis = .horizontal
    stview.distribution = .fill
    stview.alignment = .fill
    stview.translatesAutoresizingMaskIntoConstraints = false
    return stview
  }()
  
  let memberIdField: UITextField = {
    let tf = UITextField()
    tf.frame.size.height = 22
    tf.textColor = .black
    tf.borderStyle = .roundedRect
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.clearsOnBeginEditing = false
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.text = "이       름:"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let nameTextField: UITextField = {
    let tf = UITextField()
    tf.frame.size.height = 22
    tf.borderStyle = .roundedRect
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.clearsOnBeginEditing = false
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  lazy var nameStackView: UIStackView = {
    let stview = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
    stview.spacing = 5
    stview.axis = .horizontal
    stview.distribution = .fill
    stview.alignment = .fill
    stview.translatesAutoresizingMaskIntoConstraints = false
    return stview
  }()
  
  let ageLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.text = "나       이:"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let ageTextField: UITextField = {
    let tf = UITextField()
    tf.frame.size.height = 22
    tf.borderStyle = .roundedRect
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.clearsOnBeginEditing = false
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  lazy var ageStackView: UIStackView = {
    let stview = UIStackView(arrangedSubviews: [ageLabel, ageTextField])
    stview.spacing = 5
    stview.axis = .horizontal
    stview.distribution = .fill
    stview.alignment = .fill
    stview.translatesAutoresizingMaskIntoConstraints = false
    return stview
  }()
  
  let phoneNumberLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.text = "전화번호:"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let phoneNumberTextField: UITextField = {
    let tf = UITextField()
    tf.frame.size.height = 22
    tf.borderStyle = .roundedRect
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.clearsOnBeginEditing = false
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  lazy var phoneNumberStackView: UIStackView = {
    let stview = UIStackView(arrangedSubviews: [phoneNumberLabel, phoneNumberTextField])
    stview.spacing = 5
    stview.axis = .horizontal
    stview.distribution = .fill
    stview.alignment = .fill
    stview.translatesAutoresizingMaskIntoConstraints = false
    return stview
  }()
  
  let addressLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.text = "주       소:"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let addressTextField: UITextField = {
    let tf = UITextField()
    tf.frame.size.height = 22
    tf.borderStyle = .roundedRect
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.clearsOnBeginEditing = false
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  lazy var addressStackView: UIStackView = {
    let stview = UIStackView(arrangedSubviews: [addressLabel, addressTextField])
    stview.spacing = 5
    stview.axis = .horizontal
    stview.distribution = .fill
    stview.alignment = .fill
    stview.translatesAutoresizingMaskIntoConstraints = false
    return stview
  }()
  
  let saveButton: UIButton = {
    let button = UIButton(type: .custom)
    button.backgroundColor = .systemBlue
    button.setTitle("UPDATE", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.frame.size.height = 40
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  lazy var stackView: UIStackView = {
    let stview = UIStackView(arrangedSubviews: [imageContainView, memberIdStackView, nameStackView, ageStackView, phoneNumberStackView, addressStackView, saveButton])
    stview.spacing = 10
    stview.axis = .vertical
    stview.distribution = .fill
    stview.alignment = .fill
    stview.translatesAutoresizingMaskIntoConstraints = false
    return stview
  }()
  
  // 레이블 넓이 저장을 위한 속성
  let labelWidth: CGFloat = 70
  // 애니메이션을 위한 속성 선언
  var stackViewTopConstraint: NSLayoutConstraint!
  
  //MARK: - 생성자 세팅
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    setupStackView()
    setupNotification()
    setupMemberIdTextField()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupStackView() {
    self.addSubview(stackView)
  }
  
  //MARK: - 노티피케이션 셋팅
  
  func setupNotification() {
    // 노티피케이션의 등록 ⭐️
    // (OS차원에서 어떤 노티피케이션이 발생하는지 이미 정해져 있음)
    // 키보드 올라왔을 때
    NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
    // 키보드 내려갔을 때
    NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func setupMemberIdTextField() {
    memberIdTextField.delegate = self
  }
  
  //MARK: - 오토레이아웃 셋팅
  
  // 오토레이아웃 업데이트
  override func updateConstraints() {
    setConstraints()
    super.updateConstraints()
  }
  
  func setConstraints() {
    
    NSLayoutConstraint.activate([
      mainImageView.heightAnchor.constraint(equalToConstant: 150),
      mainImageView.widthAnchor.constraint(equalToConstant: 150),
      mainImageView.centerXAnchor.constraint(equalTo: imageContainView.centerXAnchor),
      mainImageView.centerYAnchor.constraint(equalTo: imageContainView.centerYAnchor)
    ])
    
    NSLayoutConstraint.activate([
      imageContainView.heightAnchor.constraint(equalToConstant: 180)
    ])
    
    NSLayoutConstraint.activate([
      memberIdLabel.widthAnchor.constraint(equalToConstant: labelWidth),
      nameLabel.widthAnchor.constraint(equalToConstant: labelWidth),
      ageLabel.widthAnchor.constraint(equalToConstant: labelWidth),
      phoneNumberLabel.widthAnchor.constraint(equalToConstant: labelWidth),
      addressLabel.widthAnchor.constraint(equalToConstant: labelWidth)
    ])
    
    stackViewTopConstraint = stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10)
    
    NSLayoutConstraint.activate([
      stackViewTopConstraint,
      stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
    ])
  }
  
  //MARK: - 키보드가 나타날때와 내려갈때의 애니메이션 셋팅
  
  @objc func moveUpAction() {
    stackViewTopConstraint.constant = -20
    UIView.animate(withDuration: 0.2) {
        self.layoutIfNeeded()
    }
  }
  
  @objc func moveDownAction() {
    stackViewTopConstraint.constant = 10
    UIView.animate(withDuration: 0.2) {
        self.layoutIfNeeded()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.endEditing(true)
  }
  
  //MARK: - 소멸자 구현
  
  deinit {
    // 노티피케이션의 등록 해제 (해제안하면 계속 등록될 수 있음) ⭐️
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
}

//MARK: - 텍스트필드 델리게이트 구현

extension DetailView: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    // 멤버 아이디는 수정 못하도록 설정 (멤버아이디의 텍스트필드는 입력 안되도록 설정)
    if textField == memberIdTextField {
        return false
    }
    
    // 나머지 텍스트필드는 관계없이 설정 가능
    return true
  }
}

