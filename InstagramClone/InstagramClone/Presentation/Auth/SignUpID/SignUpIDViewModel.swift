//
//  SignUpIDViewModel.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/22.
//

import Foundation
import RxSwift
import RxRelay

final class SignUpIDViewModel {
    private let signUpUseCase: SignUpUseCase = SignUpUseCase()
    private var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let idDidEditEvent: Observable<String>
        let tapNext: Observable<Void>
    }
    
    struct Output {
        let enableNext = PublishRelay<Bool>()
        let errorMessage = PublishRelay<String>()
        let goToNext = PublishRelay<Bool>()
    }
    
    func transform(from input: Input) -> Output {
        input.idDidEditEvent
            .subscribe(onNext: { id in
                UserInfo.password = id
            })
            .disposed(by: self.disposeBag)
        
        return createOutput(from: input)
    }
    
    private func createOutput(from input: Input) -> Output {
        let output = Output()
        
        self.signUpUseCase.signUpError
            .subscribe(onNext: { error in
                switch error {
                case .idEmpty:
                    output.errorMessage.accept("비밀번호가 입력되지 않았습니다.")
                case .alreadyExist:
                    output.errorMessage.accept("비밀번호가 입력되지 않았습니다.")
                default:
                    output.errorMessage.accept("알 수 없는 에러 : \(error)")
                }
            })
            .disposed(by: self.disposeBag)
        
        input.idDidEditEvent
            .map{ $0.count > 0 }
            .bind(to: output.enableNext)
            .disposed(by: self.disposeBag)
        
        input.tapNext
            .subscribe(onNext: { _ in
                output.goToNext.accept(true)
            })
            .disposed(by: self.disposeBag)
        
        return output
    }
}
