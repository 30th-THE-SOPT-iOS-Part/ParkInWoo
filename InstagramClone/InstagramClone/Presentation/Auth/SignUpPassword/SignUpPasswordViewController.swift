//
//  SignUpPasswordViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpPasswordViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = SignUpPasswordViewModel()
    
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
        label.text = "비밀번호 만들기".localized()
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호를 저장할 수 있으므로 iColud® 기기에서 로그인 정보를 입력하지 않아도 됩니다".localized()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var inputTextField: PadedTextField = {
        let textField = PadedTextField()
        textField.placeholder = "비밀번호".localized()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 3
        textField.backgroundColor = .systemGray6
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.rightView = self.toggleShowHideButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var toggleShowHideButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = .hiddenEye
        config.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 5)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showHideDidTouch), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "다음".localized()
        button.configuration = config
        button.isUserInteractionEnabled = false
        button.layer.opacity = 0.5
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
    
    @objc private func showHideDidTouch() {
        self.inputTextField.isSecureTextEntry.toggle()
        if self.inputTextField.isSecureTextEntry {
            self.toggleShowHideButton.setImage(.hiddenEye, for: .normal)
        } else {
            self.toggleShowHideButton.setImage(.shownEye, for: .normal)
        }
    }
    
    @objc private func backDidTouch() {
        self.navigationController?.popViewController(animated: true)
    }
}

private extension SignUpPasswordViewController {
    func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        self.defaultScrollViewConfigure()
        self.backButtonConfigure()
        self.titleLabelConfigure()
        self.guideLabelConfigure()
        self.nameTextFieldConfigure()
        self.nextButtonConfigure()
    }
    
    func defaultScrollViewConfigure() {
        self.view.addSubview(self.defaultScrollView)
        self.defaultScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.defaultScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.defaultScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.defaultScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.defaultScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func backButtonConfigure() {
        self.defaultScrollView.addSubview(self.backButton)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backButton.topAnchor.constraint(equalTo: self.defaultScrollView.topAnchor, constant: 14),
            self.backButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    func titleLabelConfigure() {
        self.defaultScrollView.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 10),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func guideLabelConfigure() {
        self.defaultScrollView.addSubview(self.guideLabel)
        self.guideLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.guideLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 19),
            self.guideLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            self.guideLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -80)
        ])
    }
    
    func nameTextFieldConfigure() {
        self.defaultScrollView.addSubview(self.inputTextField)
        self.inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.inputTextField.topAnchor.constraint(equalTo: self.guideLabel.bottomAnchor, constant: 19),
            self.inputTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.inputTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.inputTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func nextButtonConfigure() {
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
    
    func bindViewModel() {
        let input = SignUpPasswordViewModel.Input(
            passwordDidEditEvent: self.inputTextField.rx.text.orEmpty.asObservable(),
            tapNext: self.nextButton.rx.tap.asObservable()
        )
        
        let output = self.viewModel.transform(from: input)
        
        output.enableNext
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] result in
                self?.nextButton.isUserInteractionEnabled = result
                self?.nextButton.alpha = result ? 1 : 0.5
            })
            .disposed(by: self.disposeBag)
        
        output.goToNext
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] result in
                if !result { return }
                let welcomeViewController = WelcomeViewController()
                welcomeViewController.modalPresentationStyle = .fullScreen
                self?.present(welcomeViewController, animated: true) {
                    self?.navigationController?.popToRootViewController(animated: false)
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
