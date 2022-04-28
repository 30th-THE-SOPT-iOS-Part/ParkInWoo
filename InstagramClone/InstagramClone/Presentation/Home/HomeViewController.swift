//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/21.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var logoImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.image = Asset.Common.logo
        return imageView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "icn_add")))
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "icn_unlike")))
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "icn_share")))
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var storyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 58, height: 72)
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: StoryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var postTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViewModel()
    }

}

private extension HomeViewController {
    func configure() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        configureLogoImageView()
        configureButtonStackView()
        configureStoryCollectionView()
//        configurePostTableView()
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
    
    func configureStoryCollectionView() {
        view.addSubview(storyCollectionView)
        storyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyCollectionView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
            storyCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            storyCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -6),
            storyCollectionView.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    func configurePostTableView() {
        view.addSubview(postTableView)
    }
    
    func bindViewModel() {
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.identifier, for: indexPath) as? StoryCollectionViewCell else { return UICollectionViewCell() }
        cell.set(idx: indexPath.item % 6)
        return cell
    }
}
