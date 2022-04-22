//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/22.
//

import Foundation
import RxSwift
import RxRelay

final class LoginViewModel {
    private let loginUseCase: LoginUseCase = LoginUseCase()
    private var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let idDidEditEvent: Observable<String>
        let passwordDidEditEvent: Observable<String>
        let tapLogin: Observable<Void>
    }
    
    struct Output {
        let enableLogin = PublishRelay<Bool>()
        let errorMessage = PublishRelay<String>()
        let goToMain = PublishRelay<Bool>()
    }
    
    func transform(from input: Input) -> Output {
        input.idDidEditEvent
            .subscribe(onNext: { id in
                self.loginUseCase.id = id
            })
            .disposed(by: self.disposeBag)
        
        input.passwordDidEditEvent
            .subscribe(onNext: { password in
                self.loginUseCase.password = password
            })
            .disposed(by: self.disposeBag)
        
        input.tapLogin
            .subscribe(onNext: { _ in
                self.loginUseCase.execute()
            })
            .disposed(by: self.disposeBag)
        
        return createOutput(from: input)
    }
    
    private func createOutput(from input: Input) -> Output {
        let output = Output()
        
        self.loginUseCase.loginSuccess
            .subscribe(onNext: { _ in
                output.goToMain.accept(true)
            })
            .disposed(by: self.disposeBag)
        
        self.loginUseCase.loginError
            .subscribe(onNext: { error in
                switch error {
                case .idNotMatch:
                    output.errorMessage.accept("존재하지 않는 ID입니다.")
                case .pwNotMatch:
                    output.errorMessage.accept("비밀번호가 일치하지 않습니다.")
                }
            })
            .disposed(by: self.disposeBag)
        
        Observable.combineLatest(input.idDidEditEvent, input.passwordDidEditEvent)
                    .map{ !$0.0.isEmpty && !$0.1.isEmpty }
                    .bind(to: output.enableLogin)
                    .disposed(by: self.disposeBag)
        
        return output
    }
    
}
