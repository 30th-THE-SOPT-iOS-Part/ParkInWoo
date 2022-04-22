//
//  LoginUseCase.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/22.
//

import RxSwift
import RxRelay

enum LoginError: Error {
    case idNotMatch
    case pwNotMatch
}

final class LoginUseCase {
    let loginError = PublishRelay<LoginError>()
    let loginSuccess = PublishRelay<Void>()
    
    func execute(id: String, pw: String) {
        guard let user = MockUserInfo.list[id] else {
            self.loginError.accept(LoginError.idNotMatch)
            return
        }
        
        if user.pw != pw {
            self.loginError.accept(LoginError.pwNotMatch)
            return
        }
        
        loginSuccess.accept(())
    }
}
