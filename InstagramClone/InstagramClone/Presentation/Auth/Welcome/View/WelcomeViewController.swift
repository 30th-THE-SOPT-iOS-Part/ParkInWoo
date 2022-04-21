//
//  WelcomeViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    private lazy var outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        if let id = User.shared.id {
            label.text = "\(id)\("님".localized()) \("Instagram에 오신 것을 환영합니다".localized())"
        }
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    private lazy var guideLabel: UILabel = {
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
        self.configure()
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        self.outerStackViewConfigure()
        self.titleLabelConfigure()
        self.guideLabelConfigure()
        self.completeButtonConfigure()
        self.loginLabelConfigure()
    }
    
    private func outerStackViewConfigure() {
        self.view.addSubview(self.outerStackView)
        self.outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.outerStackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func titleLabelConfigure() {
        self.outerStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 75),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -75)
        ])
    }
    
    private func guideLabelConfigure() {
        self.outerStackView.addArrangedSubview(self.guideLabel)
        self.guideLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.guideLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            self.guideLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -35)
        ])
    }
    
    private func completeButtonConfigure() {
        self.outerStackView.addArrangedSubview(self.completeButton)
        self.completeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.completeButton.leadingAnchor.constraint(equalTo: self.guideLabel.leadingAnchor),
            self.completeButton.trailingAnchor.constraint(equalTo: self.guideLabel.trailingAnchor),
            self.completeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func loginLabelConfigure() {
        self.outerStackView.addArrangedSubview(self.loginLabel)
    }
    
    @objc private func completeDidTouch() {
        let mainTabBarController = TabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        self.present(mainTabBarController, animated: false)
    }
    
    @objc private func loginDidTouch() {
        self.dismiss(animated: true)
    }

}
