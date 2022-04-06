//
//  SignUpViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit

class SignUpFirstViewController: UIViewController {
    
    private lazy var defaultScrollView = UIScrollView()
    private lazy var backButton = UIButton()
    private lazy var titleLabel = UILabel()
    private lazy var guideLabel = UILabel()
    private lazy var nameTextField = PadedTextField()
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
        self.titleLabel.text = "사용자 이름 만들기"
        self.titleLabel.font = .systemFont(ofSize: 23)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 80),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func guideLabelConfigure() {
        self.defaultScrollView.addSubview(self.guideLabel)
        self.guideLabel.text = "새 계정에 사용할 사용자 이름을 선택하세요. 나중에 언제든지 변경할 수 있습니다."
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
        self.defaultScrollView.addSubview(self.nameTextField)
        self.nameTextField.placeholder = "사용자 이름"
        self.nameTextField.layer.borderWidth = 1
        self.nameTextField.layer.borderColor = UIColor.systemGray3.cgColor
        self.nameTextField.layer.cornerRadius = 3
        self.nameTextField.backgroundColor = .systemGray6
        self.nameTextField.clearButtonMode = .whileEditing
        
        self.nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameTextField.topAnchor.constraint(equalTo: self.guideLabel.bottomAnchor, constant: 20),
            self.nameTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
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
            self.nextButton.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 20),
            self.nextButton.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.nextButton.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.nextButton.bottomAnchor.constraint(equalTo: self.defaultScrollView.bottomAnchor)
        ])
    }
    
    @objc private func backDidTouch() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextDidTouch() {
        let signUpSecondViewController = SignUpSecondViewController()
        self.navigationController?.pushViewController(signUpSecondViewController, animated: true)
    }
    
}
