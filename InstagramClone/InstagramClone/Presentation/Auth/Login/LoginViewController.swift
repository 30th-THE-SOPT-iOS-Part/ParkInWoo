//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = LoginViewModel()
    
    private lazy var defaultScrollView = UIScrollView()
    
    private lazy var logoImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.image = .logo
        return imageView
    }()
    
    private lazy var idTextField: PadedTextField = {
        let textField = PadedTextField()
        textField.placeholder = "전화번호, 사용자 이름 또는 이메일".localized()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 3
        textField.backgroundColor = .systemGray6
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var pwTextField: PadedTextField = {
        let textField = PadedTextField()
        textField.placeholder = "비밀번호".localized()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 3
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.rightView = self.toggleShowHideButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var toggleShowHideButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = .shownEye
        config.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 5)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showHideDidTouch), for: .touchUpInside)
        return button
    }()
    
    private lazy var pwForgotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.text = "비밀번호를 잊으셨나요?".localized()
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "로그인".localized()
        button.configuration = config
        button.isUserInteractionEnabled = false
        button.layer.opacity = 0.5
        return button
    }()
    
    private lazy var labelOuterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(self.noAccountLabel)
        stackView.addArrangedSubview(self.signUpLabel)
        stackView.spacing = 3
        return stackView
    }()
    
    private lazy var noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "계정이 없으신가요?".localized()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "가입하기".localized()
        label.textColor = .systemBlue
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 14)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(signUpDidTouch))
        label.addGestureRecognizer(tapGestureRecognizer)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bind()
    }
    
    @objc private func showHideDidTouch() {
        self.pwTextField.isSecureTextEntry.toggle()
        if self.pwTextField.isSecureTextEntry {
            self.toggleShowHideButton.setImage(.shownEye, for: .normal)
        } else {
            self.toggleShowHideButton.setImage(.hiddenEye, for: .normal)
        }
    }
    
    @objc private func signUpDidTouch() {
        let signUpViewController = SignUpIDViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
}

extension LoginViewController {
    private func configureUI() {
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
            self.defaultScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.defaultScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.defaultScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.defaultScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func logoImageViewConfigure() {
        self.defaultScrollView.addSubview(self.logoImageView)
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.defaultScrollView.topAnchor, constant: 170),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func idTextFieldConfigure() {
        self.defaultScrollView.addSubview(self.idTextField)
        self.idTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.idTextField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 33),
            self.idTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.idTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.idTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func pwTextFieldConfigure() {
        self.defaultScrollView.addSubview(self.pwTextField)
        self.pwTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pwTextField.topAnchor.constraint(equalTo: self.idTextField.bottomAnchor, constant: 16),
            self.pwTextField.leadingAnchor.constraint(equalTo: self.idTextField.leadingAnchor),
            self.pwTextField.trailingAnchor.constraint(equalTo: self.idTextField.trailingAnchor),
            self.pwTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func pwForgotLabelCongifugure() {
        self.defaultScrollView.addSubview(self.pwForgotLabel)
        self.pwForgotLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pwForgotLabel.topAnchor.constraint(equalTo: self.pwTextField.bottomAnchor, constant: 15),
            self.pwForgotLabel.leadingAnchor.constraint(equalTo: self.pwTextField.leadingAnchor)
        ])
    }
    
    private func loginButtonCongifugure() {
        self.defaultScrollView.addSubview(self.loginButton)
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(equalTo: self.pwForgotLabel.bottomAnchor, constant: 34),
            self.loginButton.leadingAnchor.constraint(equalTo: self.pwTextField.leadingAnchor),
            self.loginButton.trailingAnchor.constraint(equalTo: self.pwTextField.trailingAnchor),
            self.loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func labelOuterStackViewCongifugure() {
        self.defaultScrollView.addSubview(self.labelOuterStackView)
        self.labelOuterStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.labelOuterStackView.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 34),
            self.labelOuterStackView.centerXAnchor.constraint(equalTo: self.defaultScrollView.centerXAnchor),
            self.labelOuterStackView.bottomAnchor.constraint(equalTo: self.defaultScrollView.bottomAnchor)
        ])
    }
    
    private func bind() {
        let input = LoginViewModel.Input(
            idDidEditEvent: self.idTextField.rx.text.orEmpty.asObservable(),
            passwordDidEditEvent: self.pwTextField.rx.text.orEmpty.asObservable(),
            tapLogin: self.loginButton.rx.tap.asObservable()
        )
        
        let output = self.viewModel.transform(from: input)
        
        output.enableLogin
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] result in
                self?.loginButton.isUserInteractionEnabled = result
                self?.loginButton.alpha = result ? 1 : 0.5
            })
            .disposed(by: self.disposeBag)
        
        output.goToMain
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] result in
                if !result { return }
                let welcomeViewController = WelcomeViewController()
                welcomeViewController.modalPresentationStyle = .fullScreen
                self?.present(welcomeViewController, animated: true) {
                    self?.idTextField.text = nil
                    self?.pwTextField.text = nil
                }
            })
            .disposed(by: self.disposeBag)
        
        output.errorMessage
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { error in
                // TODO: 에러처리
                print(error)
            })
            .disposed(by: self.disposeBag)
    }
}
