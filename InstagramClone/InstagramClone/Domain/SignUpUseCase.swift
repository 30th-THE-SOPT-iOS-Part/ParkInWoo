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
    case networkError
}

final class SignUpUseCase {
    let signUpError = PublishRelay<SignUpError>()
    let signUpSuccess = PublishRelay<Void>()
    let disposeBag = DisposeBag()
    
    func execute() {
        guard let id = User.id else {
            self.signUpError.accept(SignUpError.idEmpty)
            return
        }
        
        guard let pw = User.password else {
            self.signUpError.accept(SignUpError.passwordEmpty)
            return
        }
        
        do {
            let response = try NetworkService.shared.signUpRequest(id: id, password: pw)
            
            response
                .subscribe(onNext: { [weak self] signUpResponse in
                    guard let signUpResponse = signUpResponse else { return }
                    
                    if signUpResponse.status == 409 {
                        self?.signUpError.accept(SignUpError.alreadyExist)
                        return
                    }
                    
                    if signUpResponse.status == 201 {
                        self?.signUpSuccess.accept(())
                    }
                })
                .disposed(by: disposeBag)
        } catch {
            signUpError.accept(SignUpError.networkError)
        }
    }
}
