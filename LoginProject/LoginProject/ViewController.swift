//
//  ViewController.swift
//  LoginProject
//
//  Created by 뜌딩 on 2023/04/18.
//

import UIKit

class ViewController: UIViewController {

  // MARK: 이메일 입력하는 텍스트 뷰
  // addSubview를 클로저 안에서 하려고 lazy var로 선언
  private lazy var emailTextFieldView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.darkGray
    view.layer.cornerRadius = 5
    view.clipsToBounds = true
    view.addSubview(emailTextField)
    view.addSubview(emailInfoLabel) //뒤에 올린 뷰가 더 위에 올라와있음!!
    return view
  }()
  
  // (아이디) 안내 문구
  private var emailInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "이메일 또는 전화번호"
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = UIColor.white
    return label
  }()
  
  // 로그인 - 이메일 입력 필드
  private lazy var emailTextField: UITextField = {
    var tf = UITextField()
    tf.frame.size.height = 48
    tf.backgroundColor = .clear
    tf.textColor = .white
    tf.tintColor = .white
    tf.autocapitalizationType = .none //앞글자를 대문자로?
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.keyboardType = .emailAddress
    //tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    return tf
  }()
  
  // MARK: 비밀번호 입력하는 텍스트 뷰
  private lazy var passwordTextFieldView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.darkGray
    view.layer.cornerRadius = 5
    view.clipsToBounds = true
    view.addSubview(passwordTextField)
    view.addSubview(passwordInfoLabel)
    view.addSubview(passwordSecureButton)
    return view
  }()
  
  // (패스워드) 안내 문구
  private var passwordInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "비밀번호"
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = UIColor.white
    return label
  }()
  
  // 로그인 - 비밀번호 입력 필드
  private let passwordTextField: UITextField = {
    var tf = UITextField()
    tf.backgroundColor = UIColor.darkGray
    tf.frame.size.height = 48
    tf.backgroundColor = .clear
    tf.textColor = .white
    tf.tintColor = .white
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.isSecureTextEntry = true //글자를 가리는 설정
    tf.clearsOnBeginEditing = true
    //tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    return tf
  }()
  
  // 패스워드에 "표시" 버튼 올리기
  private let passwordSecureButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("표시", for: .normal)
    button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
    //button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
    return button
  }()
  
  // MARK: 로그인 버튼
  private let loginButton: UIButton = {
    let button = UIButton(type: .custom)
    button.backgroundColor = .clear
    button.layer.cornerRadius = 5
    button.clipsToBounds = true
    button.layer.borderWidth = 1
    button.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    button.setTitle("로그인", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.isEnabled = false //버튼 비활성화
    //button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    return button
  }()
  
  lazy var stackView: UIStackView = {
    let st = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
    st.spacing = 18
    st.axis = .vertical
    st.distribution = .fillEqually
    st.alignment = .fill
    return st
  }()
  
  // 비밀번호 재설정 버튼
  private let passwordResetButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.setTitle("비밀번호 재설정", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    return button
  }()
  
  // 텍스트필드 3개 및 로그인 버튼 높이 설정
  private let textViewHeight: CGFloat = 48
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    makeUI()
  }
  
  
  func makeUI() {
    view.backgroundColor = UIColor.black
    
    view.addSubview(stackView)
    view.addSubview(passwordResetButton)
    
    emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
      emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
      emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor),
      
      emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
      emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
      emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
      emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2),
      
      passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
      passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
      passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
      
      passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
      passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 2),
      passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
      passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),

      passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
      passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
      passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
      
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),
      
      passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
      passwordResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      passwordResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight)
    ])
    

    
  }


}

