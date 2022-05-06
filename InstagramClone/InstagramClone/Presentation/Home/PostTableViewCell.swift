//
//  PostTableViewCell.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/29.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    static let identifier = "StoryCollectionViewCell"
    var likeButtonAction : (() -> ())?

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar1")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let moreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icn_more")
        return imageView
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "postImage1")
        return imageView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(likeImageView)
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "icn_comment")))
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "icn_share")))
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var likeImageView: ToggleImageView = {
        let imageView = ToggleImageView()
        imageView.image = UIImage(named: "icn_unlike")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeDidTouch))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }()
    
    private let bookMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icn_bookmark")
        return imageView
    }()
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "좋아요 ?개"
        label.font = .boldSystemFont(ofSize: 10)
        return label
    }()
    
    private let nameBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용들어감"
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private let commentLabel: UILabel = {
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
    
    func configure(from post: Post) {
        profileImageView.image = UIImage(named: post.profileImageName)
        nameLabel.text = post.name
        mainImageView.image = UIImage(named: post.mainImageName)
        nameBottomLabel.text = post.name
        contentLabel.text = post.content
        likeLabel.text = "좋아요 \(post.likeCount)개"
        commentLabel.text = "댓글 \(post.commentCount)개 모두 보기"
    }
    
    @objc private func likeDidTouch() {
        likeImageView.image = likeImageView.state ? UIImage(named: "icn_unlike") : UIImage(named: "icn_like")
        likeImageView.state.toggle()
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
        contentView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            profileImageView.heightAnchor.constraint(equalToConstant: 24),
            profileImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configureNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 6),
            nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
    
    func configureMoreImageView() {
        contentView.addSubview(moreImageView)
        moreImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            moreImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            moreImageView.heightAnchor.constraint(equalToConstant: 24),
            moreImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configureMainImageView() {
        contentView.addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configureButtonStackView() {
        contentView.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8),
            buttonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
    func configureBookMarkImageView() {
        contentView.addSubview(bookMarkImageView)
        bookMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookMarkImageView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8),
            bookMarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configureLikeLabel() {
        contentView.addSubview(likeLabel)
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 10),
            likeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])
    }
    
    func configureNameBottomLabel() {
        contentView.addSubview(nameBottomLabel)
        nameBottomLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameBottomLabel.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 6),
            nameBottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])
    }
    
    func configureContentLabel() {
        contentView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: nameBottomLabel.trailingAnchor, constant: 2),
            contentLabel.centerYAnchor.constraint(equalTo: nameBottomLabel.centerYAnchor)
        ])
    }
    
    func configureCommentLabel() {
        contentView.addSubview(commentLabel)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: nameBottomLabel.bottomAnchor, constant: 4),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}
