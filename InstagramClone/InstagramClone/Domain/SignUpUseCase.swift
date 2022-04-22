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
}

final class SignUpUseCase {
    let signUpError = PublishRelay<SignUpError>()
    let signUpSuccess = PublishRelay<Void>()
    
    func execute(id: String, pw: String) {
        if let _ = MockUserInfo.list[id] {
            self.signUpError.accept(SignUpError.alreadyExist)
            return
        }
        
        self.signUpSuccess.accept(())
    }
}
