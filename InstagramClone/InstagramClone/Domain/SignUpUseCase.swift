//
//  SignUpUseCase.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/22.
//

import Foundation
import RxSwift
import RxRelay

enum SignUpError: Error {
    case alreadyExist
    case idEmpty
    case passwordEmpty
}

final class SignUpUseCase {
    let signUpError = PublishRelay<SignUpError>()
    let signUpSuccess = PublishRelay<Void>()
    
    func execute() {
        guard let id = User.id else {
            self.signUpError.accept(SignUpError.idEmpty)
            return
        }
        
        guard let pw = User.password else {
            self.signUpError.accept(SignUpError.passwordEmpty)
            return
        }
        
        if let _ = MockUserInfo.list[id] {
            self.signUpError.accept(SignUpError.alreadyExist)
            return
        }
        
        MockUserInfo.list[id] = User(id: id, pw: pw)
        self.signUpSuccess.accept(())
    }
}
