//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/21.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let defaultScrollView = UIScrollView()
    
    private lazy var storyCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
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
        configureDefaultScrollView()
        configureStoryCollectionView()
        configurePostTableView()
    }
    
    func configureDefaultScrollView() {
        view.addSubview(defaultScrollView)
    }
    
    func configureStoryCollectionView() {
        defaultScrollView.addSubview(storyCollectionView)
    }
    
    func configurePostTableView() {
        defaultScrollView.addSubview(postTableView)
    }
    
    func bindViewModel() {
        
    }
}
