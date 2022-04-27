//
//  SignUpIDViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpIDViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = SignUpIDViewModel()
    
    private var defaultScrollView = UIScrollView()
    
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
        return textField
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
        configure()
        bindViewModel()
    }
    
    @objc private func backDidTouch() {
        navigationController?.popViewController(animated: true)
    }    
}

private extension SignUpIDViewController {
    func configure() {
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
        let input = SignUpIDViewModel.Input(
            idDidEditEvent: inputTextField.rx.text.orEmpty.asObservable(),
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
                User.id = self?.inputTextField.text
                let signUpSecondViewController = SignUpPasswordViewController()
                self?.navigationController?.pushViewController(signUpSecondViewController, animated: true)
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
