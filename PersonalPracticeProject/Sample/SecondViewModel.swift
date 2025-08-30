//
//  SecondViewModel.swift
//  PersonalPracticeProject
//
//  Created by 박현진 on 8/30/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SecondViewModel {
    
    struct Input {
        
        let inputNum1: ControlProperty<String>
        let inputNum2: ControlProperty<String>
        let inputNum3: ControlProperty<String>


    }
    struct Output {
        
        let plusResult: PublishRelay<String>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let result = PublishRelay<String>()
        
        Observable
            .combineLatest(
                input.inputNum1,
                input.inputNum2,
                input.inputNum3
            ).bind(with: self) { owner, value in
                let a = String(value.0 + value.1 + value.2)
                result.accept(a)
            }
            .disposed(by: disposeBag)
            
        
        return Output(plusResult: result)
    }
}
