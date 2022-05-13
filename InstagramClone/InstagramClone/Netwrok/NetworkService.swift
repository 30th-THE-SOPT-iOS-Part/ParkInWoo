//
//  NetworkService.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/05/14.
//

import Foundation

import RxSwift
import RxCocoa

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func loginRequset(id: String, password: String) throws -> Observable<Data> {
        let body = ["email": id, "password": password]
        let encoder = JSONEncoder()
        let encodedBody = try encoder.encode(body)
        
        return Observable.just(APIConstants.loginURL)
            .map { URL(string: $0)! }
            .map {
                var request = URLRequest(url: $0)
                request.httpMethod = "POST"
                request.httpBody = encodedBody
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                return request
            }
            .flatMap { URLSession.shared.rx.data(request: $0) }
    }
    
    func signUpRequset(id: String, password: String) throws -> Observable<Data> {
        let body = ["email": id, "password": password]
        let encoder = JSONEncoder()
        let encodedBody = try encoder.encode(body)
        
        return Observable.just(APIConstants.signupURL)
            .map { URL(string: $0)! }
            .map {
                var request = URLRequest(url: $0)
                request.httpMethod = "POST"
                request.httpBody = encodedBody
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                return request
            }
            .flatMap { URLSession.shared.rx.data(request: $0) }
    }
}
