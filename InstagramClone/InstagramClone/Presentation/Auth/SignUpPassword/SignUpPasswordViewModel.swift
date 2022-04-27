//
//  SignUpPasswordViewModel.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/22.
//

import Foundation
import RxSwift
import RxRelay

final class SignUpPasswordViewModel {
    private let loginUseCase: LoginUseCase = LoginUseCase()
    private let signUpUseCase: SignUpUseCase = SignUpUseCase()
    private var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let passwordDidEditEvent: Observable<String>
        let tapNext: Observable<Void>
    }
    
    struct Output {
        let enableNext = PublishRelay<Bool>()
        let errorMessage = PublishRelay<String>()
        let goToNext = PublishRelay<Bool>()
    }
    
    func transform(from input: Input) -> Output {
        input.passwordDidEditEvent
            .subscribe(onNext: { password in
                User.password = password
            })
            .disposed(by: disposeBag)
        
        input.tapNext
            .subscribe(onNext: { [weak self] _ in
                self?.signUpUseCase.execute()
            })
            .disposed(by: disposeBag)
        
        return createOutput(from: input)
    }
    
    private func createOutput(from input: Input) -> Output {
        let output = Output()
        
        signUpUseCase.signUpSuccess
            .subscribe(onNext: { [weak self] _ in
                self?.loginUseCase.id = User.id
                self?.loginUseCase.password = User.password
                self?.loginUseCase.execute()
            })
            .disposed(by: disposeBag)
        
        signUpUseCase.signUpError
            .subscribe(onNext: { error in
                switch error {
                case .passwordEmpty:
                    output.errorMessage.accept("비밀번호가 입력되지 않았습니다.")
                default:
                    output.errorMessage.accept("알 수 없는 에러 : \(error)")
                }
            })
            .disposed(by: disposeBag)
        
        loginUseCase.loginSuccess
            .subscribe(onNext: { _ in
                output.goToNext.accept(true)
            })
            .disposed(by: disposeBag)
        
        input.passwordDidEditEvent
            .map{ $0.count > 0 }
            .bind(to: output.enableNext)
            .disposed(by: disposeBag)
        
        return output
    }
}
