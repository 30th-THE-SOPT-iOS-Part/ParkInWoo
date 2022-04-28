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
    
    private let defaultScrollView = UIScrollView()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = Asset.NavBar.back
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
        textField.rightView = toggleShowHideButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var toggleShowHideButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = Asset.Login.hiddenEye
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
        configureUI()
        bindViewModel()
    }
    
    @objc private func showHideDidTouch() {
        inputTextField.isSecureTextEntry.toggle()
        if inputTextField.isSecureTextEntry {
            toggleShowHideButton.setImage(Asset.Login.hiddenEye, for: .normal)
        } else {
            toggleShowHideButton.setImage(Asset.Login.shownEye, for: .normal)
        }
    }
    
    @objc private func backDidTouch() {
        navigationController?.popViewController(animated: true)
    }
}

private extension SignUpPasswordViewController {
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        defaultScrollViewConfigure()
        backButtonConfigure()
        titleLabelConfigure()
        guideLabelConfigure()
        nameTextFieldConfigure()
        nextButtonConfigure()
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
    
    func backButtonConfigure() {
        defaultScrollView.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: defaultScrollView.topAnchor, constant: 14),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    func titleLabelConfigure() {
        defaultScrollView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func guideLabelConfigure() {
        defaultScrollView.addSubview(guideLabel)
        guideLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            guideLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 19),
            guideLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            guideLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80)
        ])
    }
    
    func nameTextFieldConfigure() {
        defaultScrollView.addSubview(inputTextField)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 19),
            inputTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            inputTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            inputTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func nextButtonConfigure() {
        defaultScrollView.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 22),
            nextButton.leadingAnchor.constraint(equalTo: inputTextField.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: defaultScrollView.bottomAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func bindViewModel() {
        let input = SignUpPasswordViewModel.Input(
            passwordDidEditEvent: inputTextField.rx.text.orEmpty.asObservable(),
            tapNext: nextButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.enableNext
            .asDriver(onErrorJustReturn: false)
            .throttle(.milliseconds(300))
            .drive(onNext: { [weak self] result in
                self?.nextButton.isUserInteractionEnabled = result
                self?.nextButton.alpha = result ? 1 : 0.5
            })
            .disposed(by: disposeBag)
        
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
