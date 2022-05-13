//
//  SignUpResponse.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/05/14.
//

import Foundation

struct SignUpResponse: Codable {
    let status: Int
    let success: Bool?
    let message: String
    let data: SignUpData?
}

struct SignUpData: Codable {
    let id: Int
}
