//
//  WelcomeViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/06.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    private lazy var outerStackView = UIStackView()
    private lazy var titleLabel = UILabel()
    private lazy var guideLabel = UILabel()
    private lazy var completeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        
        self.outerStackViewConfigure()
    }
    
    private func outerStackViewConfigure() {
        self.view.addSubview(self.outerStackView)
        self.outerStackView.axis = .vertical
        self.outerStackView.alignment = .center
        self.outerStackView.spacing = 20
        self.titleLabelConfigure()
        self.guideLabelConfigure()
        self.completeButtonConfigure()
        
        self.outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.outerStackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func titleLabelConfigure() {
        self.outerStackView.addArrangedSubview(self.titleLabel)
        if let id = User.shared.id {
            self.titleLabel.text = "\(id)\(NSLocalizedString("님", comment: "")) \(NSLocalizedString("Instagram에 오신 것을 환영합니다", comment: ""))"
        }
        self.titleLabel.font = .systemFont(ofSize: 20)
        self.titleLabel.numberOfLines = 3
        self.titleLabel.textAlignment = .center
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -80)
        ])
    }
    
    private func guideLabelConfigure() {
        self.outerStackView.addArrangedSubview(self.guideLabel)
        self.guideLabel.text = NSLocalizedString("언제든지 연락처 정보와 사용자 이름을 변경할 수 있습니다", comment: "")
        self.guideLabel.font = .systemFont(ofSize: 12)
        self.guideLabel.numberOfLines = 2
        self.guideLabel.textAlignment = .center
        self.guideLabel.textColor = .systemGray
        
        self.guideLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.guideLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            self.guideLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
    
    private func completeButtonConfigure() {
        self.outerStackView.addArrangedSubview(self.completeButton)
        var config = UIButton.Configuration.filled()
        config.title = NSLocalizedString("완료하기", comment: "")
        self.completeButton.configuration = config
        self.completeButton.addTarget(self, action: #selector(completeDidTouch), for: .touchUpInside)
        
        self.completeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.completeButton.leadingAnchor.constraint(equalTo: self.guideLabel.leadingAnchor),
            self.completeButton.trailingAnchor.constraint(equalTo: self.guideLabel.trailingAnchor)
        ])
    }
    
    @objc private func completeDidTouch() {
        self.dismiss(animated: true, completion: nil)
    }

}
