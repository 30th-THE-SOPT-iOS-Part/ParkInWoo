//
//  User.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/07.
//

import Foundation

class User {
    static var shared: User = User()
    private init() {}
    
    var id: String?
    var pw: String?
}
