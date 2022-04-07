//
//  User.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/07.
//

import Foundation

struct UserInfo {
    static var shared: UserInfo = UserInfo()
    private init() {}
    
    var id: String?
    var pw: String?
}
