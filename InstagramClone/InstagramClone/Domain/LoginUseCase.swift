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
    var id: String?
    var password: String?
    let loginError = PublishRelay<LoginError>()
    let loginSuccess = PublishRelay<Void>()
    
    func execute() {
        guard let id = self.id,
              let user = MockUserInfo.list[id] else {
            self.loginError.accept(LoginError.idNotMatch)
            return
        }
        
        if user.pw != self.password {
            self.loginError.accept(LoginError.pwNotMatch)
            return
        }
        
        UserInfo.id = self.id
        UserInfo.password = self.password
        loginSuccess.accept(())
    }
}
