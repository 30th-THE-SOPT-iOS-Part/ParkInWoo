//
//  LoginResponse.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/05/14.
//

import Foundation

struct LoginResponse: Codable {
    let status: Int
    let success: Bool?
    let message: String
    let data: LoginData?
}

struct LoginData: Codable {
    let name: String
    let email: String
}
