//
//  SignUpSecondViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit

class SignUpSecondViewController: UIViewController {
    
    private lazy var defaultScrollView = UIScrollView()
    private lazy var backButton = UIButton()
    private lazy var titleLabel = UILabel()
    private lazy var guideLabel = UILabel()
    private lazy var inputTextField = PadedTextField()
    private lazy var nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }

    private func configure() {
        self.view.backgroundColor = .white
        
        self.navigationController?.isNavigationBarHidden = true
        self.defaultScrollViewConfigure()
        self.backButtonConfigure()
        self.titleLabelConfigure()
        self.guideLabelConfigure()
        self.nameTextFieldConfigure()
        self.nextButtonConfigure()
    }
    
    private func defaultScrollViewConfigure() {
        self.view.addSubview(self.defaultScrollView)
        self.defaultScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.defaultScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.defaultScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.defaultScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.defaultScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func backButtonConfigure() {
        self.defaultScrollView.addSubview(self.backButton)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "icn_back_24")
        self.backButton.configuration = config
        self.backButton.addTarget(self, action: #selector(backDidTouch), for: .touchUpInside)
        
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backButton.topAnchor.constraint(equalTo: self.defaultScrollView.topAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    private func titleLabelConfigure() {
        self.defaultScrollView.addSubview(self.titleLabel)
        self.titleLabel.text = "비밀번호 만들기"
        self.titleLabel.font = .systemFont(ofSize: 23)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 80),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func guideLabelConfigure() {
        self.defaultScrollView.addSubview(self.guideLabel)
        self.guideLabel.text = "비밀번호를 저장할 수 있으므로 iColud® 기기에서 로그인 정보를 입력하지 않아도 됩니다."
        self.guideLabel.font = .systemFont(ofSize: 12)
        self.guideLabel.numberOfLines = 2
        self.guideLabel.textAlignment = .center
        self.guideLabel.textColor = .systemGray
        
        self.guideLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.guideLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.guideLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            self.guideLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -80)
        ])
    }
    
    private func nameTextFieldConfigure() {
        self.defaultScrollView.addSubview(self.inputTextField)
        self.inputTextField.placeholder = "비밀번호"
        self.inputTextField.layer.borderWidth = 1
        self.inputTextField.layer.borderColor = UIColor.systemGray3.cgColor
        self.inputTextField.layer.cornerRadius = 3
        self.inputTextField.backgroundColor = .systemGray6
        self.inputTextField.clearButtonMode = .whileEditing
        
        self.inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.inputTextField.topAnchor.constraint(equalTo: self.guideLabel.bottomAnchor, constant: 20),
            self.inputTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.inputTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    private func nextButtonConfigure() {
        self.defaultScrollView.addSubview(self.nextButton)
        var config = UIButton.Configuration.filled()
        config.title = "다음"
        self.nextButton.configuration = config
        self.nextButton.layer.opacity = 0.5
        self.nextButton.addTarget(self, action: #selector(nextDidTouch), for: .touchUpInside)
        
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nextButton.topAnchor.constraint(equalTo: self.inputTextField.bottomAnchor, constant: 20),
            self.nextButton.leadingAnchor.constraint(equalTo: self.inputTextField.leadingAnchor),
            self.nextButton.trailingAnchor.constraint(equalTo: self.inputTextField.trailingAnchor),
            self.nextButton.bottomAnchor.constraint(equalTo: self.defaultScrollView.bottomAnchor)
        ])
    }
    
    @objc private func backDidTouch() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextDidTouch() {
        UserInfo.shared.pw = inputTextField.text
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.modalPresentationStyle = .fullScreen
        self.present(welcomeViewController, animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: false)
    }
    
}

