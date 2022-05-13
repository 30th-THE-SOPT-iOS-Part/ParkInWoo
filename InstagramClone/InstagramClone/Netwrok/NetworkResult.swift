//
//  NetworkResult.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/05/14.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestError(T)
    case pathError
    case serverError
    case networkConnectionError
}
