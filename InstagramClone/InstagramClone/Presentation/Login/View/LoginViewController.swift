//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private lazy var defaultScrollView = UIScrollView()
    private lazy var logoImageView = UIImageView()
    private lazy var idTextField = PadedTextField()
    private lazy var pwTextField = PadedTextField()
    private lazy var toggleShowHideButton = UIButton()
    private lazy var pwForgotLabel = UILabel()
    private lazy var loginButton = UIButton()
    private lazy var labelOuterStackView = UIStackView()
    private lazy var noAccountLabel = UILabel()
    private lazy var signUpLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        
        self.defaultScrollViewConfigure()
        self.logoImageViewConfigure()
        self.idTextFieldConfigure()
        self.pwTextFieldConfigure()
        self.pwForgotLabelCongifugure()
        self.loginButtonCongifugure()
        self.labelOuterStackViewCongifugure()
    }
    
    private func defaultScrollViewConfigure() {
        self.view.addSubview(self.defaultScrollView)
        self.defaultScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.defaultScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            self.defaultScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.defaultScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.defaultScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func logoImageViewConfigure() {
        self.defaultScrollView.addSubview(self.logoImageView)
        self.logoImageView.image = .logo
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.defaultScrollView.topAnchor),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func idTextFieldConfigure() {
        self.defaultScrollView.addSubview(self.idTextField)
        self.idTextField.placeholder = "전화번호, 사용자 이름 또는 이메일"
        self.idTextField.layer.borderWidth = 1
        self.idTextField.layer.borderColor = UIColor.systemGray3.cgColor
        self.idTextField.layer.cornerRadius = 3
        self.idTextField.backgroundColor = .systemGray6
        self.idTextField.clearButtonMode = .whileEditing
        self.idTextField.delegate = self
        
        self.idTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.idTextField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 30),
            self.idTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.idTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    private func pwTextFieldConfigure() {
        self.defaultScrollView.addSubview(self.pwTextField)
        self.pwTextField.placeholder = "비밀번호"
        self.pwTextField.layer.borderWidth = 1
        self.pwTextField.layer.borderColor = UIColor.systemGray3.cgColor
        self.pwTextField.layer.cornerRadius = 3
        self.pwTextField.backgroundColor = .systemGray6
        self.pwTextField.isSecureTextEntry = true
        self.pwTextField.delegate = self
       
        var config = UIButton.Configuration.plain()
        config.image = .shownEye
        config.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 5)
        self.toggleShowHideButton.configuration = config
        self.toggleShowHideButton.translatesAutoresizingMaskIntoConstraints = false
        self.toggleShowHideButton.addTarget(self, action: #selector(showHideDidTouch), for: .touchUpInside)
        
        self.pwTextField.rightView = self.toggleShowHideButton
        self.pwTextField.rightViewMode = .always
        
        self.pwTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pwTextField.topAnchor.constraint(equalTo: self.idTextField.bottomAnchor, constant: 10),
            self.pwTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.pwTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    private func pwForgotLabelCongifugure() {
        self.defaultScrollView.addSubview(self.pwForgotLabel)
        self.pwForgotLabel.textColor = .systemBlue
        self.pwForgotLabel.text = "비밀번호를 잊으셨나요?"
        self.pwForgotLabel.font = .systemFont(ofSize: 13)
        
        self.pwForgotLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pwForgotLabel.topAnchor.constraint(equalTo: self.pwTextField.bottomAnchor, constant: 15),
            self.pwForgotLabel.trailingAnchor.constraint(equalTo: self.pwTextField.trailingAnchor)
        ])
    }
    
    private func loginButtonCongifugure() {
        self.defaultScrollView.addSubview(self.loginButton)
        var config = UIButton.Configuration.filled()
        config.title = "로그인"
        self.loginButton.configuration = config
        self.loginButton.isUserInteractionEnabled = false
        self.loginButton.layer.opacity = 0.5
        self.loginButton.addTarget(self, action: #selector(loginDidTouch), for: .touchUpInside)
        
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(equalTo: self.pwForgotLabel.bottomAnchor, constant: 15),
            self.loginButton.leadingAnchor.constraint(equalTo: self.pwTextField.leadingAnchor),
            self.loginButton.trailingAnchor.constraint(equalTo: self.pwTextField.trailingAnchor)
        ])
    }
    
    private func labelOuterStackViewCongifugure() {
        self.defaultScrollView.addSubview(self.labelOuterStackView)
        self.labelOuterStackView.axis = .horizontal
        self.labelOuterStackView.addArrangedSubview(self.noAccountLabel)
        self.labelOuterStackView.addArrangedSubview(self.signUpLabel)
        self.labelOuterStackView.spacing = 3
        
        self.noAccountLabel.text = "계정이 없으신가요?"
        self.noAccountLabel.textColor = .systemGray
        self.signUpLabel.text = "가입하기"
        self.signUpLabel.textColor = .systemBlue
        self.signUpLabel.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(signUpDidTouch))
        self.signUpLabel.addGestureRecognizer(tapGestureRecognizer)
        
        self.labelOuterStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.labelOuterStackView.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 20),
            self.labelOuterStackView.centerXAnchor.constraint(equalTo: self.defaultScrollView.centerXAnchor),
            self.labelOuterStackView.bottomAnchor.constraint(equalTo: self.defaultScrollView.bottomAnchor)
        ])
    }
    
    @objc private func showHideDidTouch() {
        self.pwTextField.isSecureTextEntry.toggle()
        if self.pwTextField.isSecureTextEntry {
            self.toggleShowHideButton.setImage(.shownEye, for: .normal)
        } else {
            self.toggleShowHideButton.setImage(.hiddenEye, for: .normal)
        }
    }
    
    @objc private func loginDidTouch() {
        UserInfo.shared.id = idTextField.text
        UserInfo.shared.pw = pwTextField.text
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.modalPresentationStyle = .fullScreen
        self.present(welcomeViewController, animated: true, completion: nil)
    }
    
    @objc private func signUpDidTouch() {
        let signUpViewController = SignUpFirstViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if idTextField.text?.isEmpty ?? true || pwTextField.text?.isEmpty ?? true {
            self.loginButton.isUserInteractionEnabled = false
            self.loginButton.layer.opacity = 0.5
        } else {
            self.loginButton.isUserInteractionEnabled = true
            self.loginButton.layer.opacity = 1
        }
    }
}
