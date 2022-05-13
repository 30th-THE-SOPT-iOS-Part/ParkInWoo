//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/21.
//

import UIKit

import RxSwift
import RxCocoa
import RxRelay

final class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let tableData = BehaviorRelay(value: [nil] + Post.sample)
    
    private let logoImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.image = Asset.Common.logo
        return imageView
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "icn_add")))
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "icn_unlike")))
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "icn_share")))
        stackView.spacing = 16
        return stackView
    }()
    
    private let postTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 400
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

}

private extension HomeViewController {
    func configure() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        configureLogoImageView()
        configureButtonStackView()
        configurePostTableView()
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 14),
            logoImageView.heightAnchor.constraint(equalToConstant: 27),
            logoImageView.widthAnchor.constraint(equalToConstant: 96)
        ])
    }
    
    func configureButtonStackView() {
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -14),
        ])
    }
    
    func configurePostTableView() {
        view.addSubview(postTableView)
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 11),
            postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func bind() {
        tableData
            .bind(to: postTableView.rx.items) { (tableView, row, element) in
                if row == 0 { return StoryTableViewCell() }
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell,
                    let post = element else {
                    return UITableViewCell()
                }
                cell.configure(from: post)
                return cell
            }
            .disposed(by: disposeBag)
    }
}
