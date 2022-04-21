//
//  SignUpIDViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit

final class SignUpIDViewController: UIViewController {
    
    private lazy var defaultScrollView = UIScrollView()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = .back
        button.configuration = config
        button.addTarget(self, action: #selector(backDidTouch), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자 이름 만들기".localized()
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.text = "새 계정에 사용할 사용자 이름을 선택하세요. 나중에 언제든지 변경할 수 있습니다".localized()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var inputTextField: PadedTextField = {
        let textField = PadedTextField()
        textField.placeholder = "사용자 이름".localized()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 3
        textField.backgroundColor = .systemGray6
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "다음".localized()
        button.configuration = config
        button.isUserInteractionEnabled = false
        button.layer.opacity = 0.5
        button.addTarget(self, action: #selector(nextDidTouch), for: .touchUpInside)
        return button
    }()

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
            self.defaultScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.defaultScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.defaultScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.defaultScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func backButtonConfigure() {
        self.defaultScrollView.addSubview(self.backButton)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backButton.topAnchor.constraint(equalTo: self.defaultScrollView.topAnchor, constant: 14),
            self.backButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    private func titleLabelConfigure() {
        self.defaultScrollView.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 10),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func guideLabelConfigure() {
        self.defaultScrollView.addSubview(self.guideLabel)
        self.guideLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.guideLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 19),
            self.guideLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            self.guideLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -80)
        ])
    }
    
    private func nameTextFieldConfigure() {
        self.defaultScrollView.addSubview(self.inputTextField)
        self.inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.inputTextField.topAnchor.constraint(equalTo: self.guideLabel.bottomAnchor, constant: 19),
            self.inputTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.inputTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.inputTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func nextButtonConfigure() {
        self.defaultScrollView.addSubview(self.nextButton)
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nextButton.topAnchor.constraint(equalTo: self.inputTextField.bottomAnchor, constant: 22),
            self.nextButton.leadingAnchor.constraint(equalTo: self.inputTextField.leadingAnchor),
            self.nextButton.trailingAnchor.constraint(equalTo: self.inputTextField.trailingAnchor),
            self.nextButton.bottomAnchor.constraint(equalTo: self.defaultScrollView.bottomAnchor),
            self.nextButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func backDidTouch() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextDidTouch() {
        User.shared.id = inputTextField.text
        let signUpSecondViewController = SignUpPasswordViewController()
        self.navigationController?.pushViewController(signUpSecondViewController, animated: true)
    }
    
}

extension SignUpIDViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let inputCompleted = inputTextField.hasText
        self.nextButton.isUserInteractionEnabled = inputCompleted
        self.nextButton.alpha = inputCompleted ? 1 : 0.5
    }
}
