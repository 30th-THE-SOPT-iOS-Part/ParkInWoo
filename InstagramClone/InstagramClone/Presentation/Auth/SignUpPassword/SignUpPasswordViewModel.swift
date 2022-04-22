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
                UserInfo.password = password
            })
            .disposed(by: self.disposeBag)
        
        input.tapNext
            .subscribe(onNext: { [weak self] _ in
                self?.signUpUseCase.execute()
            })
            .disposed(by: self.disposeBag)
        
        return createOutput(from: input)
    }
    
    private func createOutput(from input: Input) -> Output {
        let output = Output()
        
        self.signUpUseCase.signUpSuccess
            .subscribe(onNext: { [weak self] _ in
                self?.loginUseCase.id = UserInfo.id
                self?.loginUseCase.password = UserInfo.password
                self?.loginUseCase.execute()
            })
            .disposed(by: self.disposeBag)
        
        self.signUpUseCase.signUpError
            .subscribe(onNext: { error in
                switch error {
                case .passwordEmpty:
                    output.errorMessage.accept("비밀번호가 입력되지 않았습니다.")
                default:
                    output.errorMessage.accept("알 수 없는 에러 : \(error)")
                }
            })
            .disposed(by: self.disposeBag)
        
        self.loginUseCase.loginSuccess
            .subscribe(onNext: { _ in
                output.goToNext.accept(true)
            })
            .disposed(by: self.disposeBag)
        
        input.passwordDidEditEvent
            .map{ $0.count > 0 }
            .bind(to: output.enableNext)
            .disposed(by: self.disposeBag)
        
        return output
    }
}
