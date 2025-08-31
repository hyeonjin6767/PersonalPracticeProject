//
//  ThirdViewModel.swift
//  PersonalPracticeProject
//
//  Created by 박현진 on 8/30/25.
//

import Foundation
import RxSwift
import RxCocoa

class ThirdViewModel {
    
    struct Input {
        
//        let searchBarTap: ControlEvent<Void>
//        let searchText: ControlProperty<String>
        
        let searchBarTap: ControlProperty<String>
        let tableItem: BehaviorSubject<[Person]>
//        var tableItem: [Person]

    }
    
    struct Output {
        
        let results: PublishRelay<[Person]>
//        let results: PublishRelay<[Person]>

        
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
//        let result = PublishRelay<[Person]>()
//        
//        input.searchBarTap
//            .bind(with: self) { owner, _ in
//                let text = input.searchText.values
//                result.onNext(text)
//            }
//        

        
        let result = PublishRelay<[Person]>()

        input.searchBarTap // searchBar.rx.text.orEmpty
            .withLatestFrom(input.searchBarTap)
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                print("서치바 클릭")
                var add = try! input.tableItem.value()
                add.append(Person(name: value, email: "", profileImage: ""))
                result.accept(add)

            }
            .disposed(by: disposeBag)

        return Output(results: result)
    }
}
