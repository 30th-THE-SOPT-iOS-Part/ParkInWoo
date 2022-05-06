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
    
    private let defaultScrollView = UIScrollView()
    
    private let logoImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.image = Asset.Common.logo
        return imageView
    }()
    
    private let idTextField: PadedTextField = {
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
        textField.rightView = toggleShowHideButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var toggleShowHideButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = Asset.Login.hiddenEye
        config.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 0, bottom: 12, trailing: 10)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showHideDidTouch), for: .touchUpInside)
        return button
    }()
    
    private let pwForgotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.text = "비밀번호를 잊으셨나요?".localized()
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private let loginButton: UIButton = {
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
        stackView.addArrangedSubview(noAccountLabel)
        stackView.addArrangedSubview(signUpLabel)
        stackView.spacing = 3
        return stackView
    }()
    
    private let noAccountLabel: UILabel = {
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
        configureUI()
        bindViewModel()
    }
    
    @objc private func showHideDidTouch() {
        pwTextField.isSecureTextEntry.toggle()
        if pwTextField.isSecureTextEntry {
            toggleShowHideButton.setImage(Asset.Login.hiddenEye, for: .normal)
        } else {
            toggleShowHideButton.setImage(Asset.Login.shownEye, for: .normal)
        }
    }
    
    @objc private func signUpDidTouch() {
        let signUpViewController = SignUpIDViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}

private extension LoginViewController {
    func configureUI() {
        view.backgroundColor = .white
        defaultScrollViewConfigure()
        logoImageViewConfigure()
        idTextFieldConfigure()
        pwTextFieldConfigure()
        pwForgotLabelCongifugure()
        loginButtonCongifugure()
        labelOuterStackViewCongifugure()
    }
    
    func defaultScrollViewConfigure() {
        view.addSubview(defaultScrollView)
        defaultScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            defaultScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            defaultScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            defaultScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            defaultScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func logoImageViewConfigure() {
        defaultScrollView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: defaultScrollView.topAnchor, constant: 170),
            logoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func idTextFieldConfigure() {
        defaultScrollView.addSubview(idTextField)
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 33),
            idTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            idTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            idTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func pwTextFieldConfigure() {
        defaultScrollView.addSubview(pwTextField)
        pwTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pwTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 16),
            pwTextField.leadingAnchor.constraint(equalTo: idTextField.leadingAnchor),
            pwTextField.trailingAnchor.constraint(equalTo: idTextField.trailingAnchor),
            pwTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func pwForgotLabelCongifugure() {
        defaultScrollView.addSubview(pwForgotLabel)
        pwForgotLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pwForgotLabel.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 15),
            pwForgotLabel.leadingAnchor.constraint(equalTo: pwTextField.leadingAnchor)
        ])
    }
    
    func loginButtonCongifugure() {
        defaultScrollView.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: pwForgotLabel.bottomAnchor, constant: 34),
            loginButton.leadingAnchor.constraint(equalTo: pwTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: pwTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func labelOuterStackViewCongifugure() {
        defaultScrollView.addSubview(labelOuterStackView)
        labelOuterStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelOuterStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 34),
            labelOuterStackView.centerXAnchor.constraint(equalTo: defaultScrollView.centerXAnchor),
            labelOuterStackView.bottomAnchor.constraint(equalTo: defaultScrollView.bottomAnchor)
        ])
    }
    
    func bindViewModel() {
        let input = LoginViewModel.Input(
            idDidEditEvent: idTextField.rx.text.orEmpty.asObservable(),
            passwordDidEditEvent: pwTextField.rx.text.orEmpty.asObservable(),
            tapLogin: loginButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.enableLogin
            .asDriver(onErrorJustReturn: false)
            .throttle(.milliseconds(300))
            .drive(onNext: { [weak self] result in
                self?.loginButton.isUserInteractionEnabled = result
                self?.loginButton.alpha = result ? 1 : 0.5
            })
            .disposed(by: disposeBag)
        
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
            .disposed(by: disposeBag)
        
        output.errorMessage
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { error in
                // TODO: 에러처리
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
