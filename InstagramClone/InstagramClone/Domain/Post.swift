//
//  Post.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/05/02.
//

import Foundation

struct Post {
    var profileImageName: String
    var name: String
    var mainImageName: String
    var content: String
    var likeCount: Int
    var commentCount: Int
}

extension Post {
    static let sample: [Post?] = [
        Post(profileImageName: "avatar1", name: "one", mainImageName: "postImage1", content: "라면을 먹었다. 배가 고프다.", likeCount: 123, commentCount: 5),
        Post(profileImageName: "avatar2", name: "two", mainImageName: "postImage2", content: "오늘은 하루종일 졸업프로젝트를 했다.", likeCount: 2, commentCount: 10),
        Post(profileImageName: "avatar3", name: "inwoo", mainImageName: "postImage3", content: "인스타 감성이란 너무 어려워", likeCount: 54, commentCount: 4),
        Post(profileImageName: "avatar4", name: "four", mainImageName: "postImage4", content: "인스타접고 싸이월드합니다.", likeCount: 5, commentCount: 6),
        Post(profileImageName: "avatar5", name: "five", mainImageName: "postImage5", content: "맥북 팝니다.", likeCount: 30129, commentCount: 124)
    ]
}
