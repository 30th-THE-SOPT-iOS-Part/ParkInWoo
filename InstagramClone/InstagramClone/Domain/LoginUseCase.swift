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
    case networkError
}

final class LoginUseCase {
    var id: String?
    var password: String?
    let loginError = PublishRelay<LoginError>()
    let loginSuccess = PublishRelay<Void>()
    let disposeBag = DisposeBag()
    
    func execute() {
        guard let id = self.id,
              let password = self.password else {
            return
        }
        
        do {
            let response = try NetworkService.shared.loginRequest(id: id, password: password)
            
            response
                .subscribe(onNext: { [weak self] loginResponse in
                    guard let loginResponse = loginResponse else { return }
                    
                    if loginResponse.status == 404 {
                        self?.loginError.accept(LoginError.idNotMatch)
                        return
                    }
                    
                    if loginResponse.status == 409 {
                        self?.loginError.accept(LoginError.pwNotMatch)
                        return
                    }
                    
                    if loginResponse.status == 200 {
                        self?.loginSuccess.accept(())
                    }                    
                })
                .disposed(by: disposeBag)
        } catch {
            loginError.accept(LoginError.networkError)
        }
    }
}
