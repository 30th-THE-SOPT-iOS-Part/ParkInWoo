//
//  StoryTableViewCell.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/29.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    private func configure() {
        contentView.addSubview(storyCollectionView)
        storyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            storyCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            storyCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            storyCollectionView.heightAnchor.constraint(equalToConstant: 72),
            storyCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}

extension StoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.identifier, for: indexPath) as? StoryCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(idx: indexPath.item)
        return cell
    }
}
