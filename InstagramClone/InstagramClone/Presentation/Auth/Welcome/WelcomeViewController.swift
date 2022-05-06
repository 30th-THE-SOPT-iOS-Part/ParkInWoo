//
//  WelcomeViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        if let id = User.id {
            label.text = "\(id)\("님".localized()) \("Instagram에 오신 것을 환영합니다".localized())"
        }
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "언제든지 연락처 정보와 사용자 이름을 변경할 수 있습니다".localized()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "완료하기".localized()
        button.configuration = config
        button.addTarget(self, action: #selector(completeDidTouch), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "다른 계정으로 로그인하기".localized()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loginDidTouch))
        label.addGestureRecognizer(tapGestureRecognizer)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        configure()
    }
    
    @objc private func completeDidTouch() {
        let mainTabBarController = TabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        if let scene = UIApplication.shared.connectedScenes.first,
           let sd = scene.delegate as? SceneDelegate {
            sd.window?.rootViewController = mainTabBarController
        }
    }
    
    @objc private func loginDidTouch() {
        dismiss(animated: true)
    }
}

private extension WelcomeViewController {
    func configure() {
        view.backgroundColor = .white
        outerStackViewConfigure()
        titleLabelConfigure()
        guideLabelConfigure()
        completeButtonConfigure()
        loginLabelConfigure()
    }
    
    func outerStackViewConfigure() {
        view.addSubview(outerStackView)
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func titleLabelConfigure() {
        outerStackView.addArrangedSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 75),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -75)
        ])
    }
    
    func guideLabelConfigure() {
        outerStackView.addArrangedSubview(guideLabel)
        guideLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            guideLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            guideLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35)
        ])
    }
    
    func completeButtonConfigure() {
        outerStackView.addArrangedSubview(completeButton)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            completeButton.leadingAnchor.constraint(equalTo: guideLabel.leadingAnchor),
            completeButton.trailingAnchor.constraint(equalTo: guideLabel.trailingAnchor),
            completeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func loginLabelConfigure() {
        outerStackView.addArrangedSubview(loginLabel)
    }
}
