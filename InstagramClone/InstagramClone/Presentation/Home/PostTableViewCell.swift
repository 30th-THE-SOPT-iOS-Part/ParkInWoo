//
//  PostTableViewCell.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/29.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    static let identifier = "StoryCollectionViewCell"

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar1")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var moreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icn_more")
        return imageView
    }()
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "postImage1")
        return imageView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "icn_comment")))
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "icn_share")))
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var likeButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icn_unlike")
        return imageView
    }()
    
    private lazy var bookMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icn_bookmark")
        return imageView
    }()
    
    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.text = "좋아요 ?개"
        label.font = .boldSystemFont(ofSize: 10)
        return label
    }()
    
    private lazy var nameBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용들어감"
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글 ?개 모두 보기"
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
}

private extension PostTableViewCell {
    func configure() {
        configureProfileImageView()
        configureNameLabel()
        configureMoreImageView()
        configureMainImageView()
        configureButtonStackView()
        configureBookMarkImageView()
        configureLikeLabel()
        configureNameBottomLabel()
        configureContentLabel()
        configureCommentLabel()
    }
    
    func configureProfileImageView() {
        self.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            profileImageView.heightAnchor.constraint(equalToConstant: 24),
            profileImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configureNameLabel() {
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 6),
            nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
    
    func configureMoreImageView() {
        self.addSubview(moreImageView)
        moreImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            moreImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            moreImageView.heightAnchor.constraint(equalToConstant: 24),
            moreImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configureMainImageView() {
        self.addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor)
        ])
    }
    
    func configureButtonStackView() {
        self.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8),
            buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    func configureBookMarkImageView() {
        self.addSubview(bookMarkImageView)
        bookMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookMarkImageView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8),
            bookMarkImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func configureLikeLabel() {
        self.addSubview(likeLabel)
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 10),
            likeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12)
        ])
    }
    
    func configureNameBottomLabel() {
        self.addSubview(nameBottomLabel)
        nameBottomLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameBottomLabel.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 6),
            nameBottomLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12)
        ])
    }
    
    func configureContentLabel() {
        self.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: nameBottomLabel.trailingAnchor, constant: 2),
            contentLabel.centerYAnchor.constraint(equalTo: nameBottomLabel.centerYAnchor)
        ])
    }
    
    func configureCommentLabel() {
        self.addSubview(commentLabel)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: nameBottomLabel.bottomAnchor, constant: 4),
            commentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            commentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
}
