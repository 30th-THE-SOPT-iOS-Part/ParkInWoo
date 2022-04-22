//
//  User.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/07.
//

import Foundation

final class User {
    static var shared = User(id: "", pw: "")
    
    init(id: String, pw: String) {
        self.id = id
        self.pw = pw
    }
    
    var id: String?
    var pw: String?
}
