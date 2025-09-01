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
        
        let searchBarTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
        
//        let searchBarTap: ControlProperty<String>
        let tableItem: BehaviorSubject<[Person]>
//        var tableItem: [Person]
        
        
//        let itemSelected: ControlEvent<IndexPath>
        let modelSelected: ControlEvent<Person>
        
//        let collectionItems: BehaviorRelay<[String]>
//        let collectionItems: PublishSubject<[String]>
        
        

    }
    
    struct Output {
        
        let results: PublishRelay<[Person]>
//        let results: PublishRelay<[Person]>

        let selectResult: PublishSubject<[String]>
        
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
//        let testA = Observable.just("A")
//        let testB = BehaviorRelay(value: "B")
//        let testC = PublishRelay<String>()
//        
//        let itemResult = BehaviorRelay<[String]>(value: [""])
        let itemResult = PublishSubject<[String]>()

        
//        
//        Observable.zip(
//            input.itemSelected, //tableView.rx.itemSelected,
//            input.modelSelected //tableView.rx.modelSelected(Person.self)
//        )
        input.modelSelected
            .bind(with: self) { owner, value in
            print("셀클릭확인 : ",value.name)
                itemResult.onNext([value.name])

        }
        .disposed(by: disposeBag)
        
        
        
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
            .withLatestFrom(input.searchText)
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                print("서치바 클릭")
                var add = try! input.tableItem.value()
                add.append(Person(name: value, email: "", profileImage: ""))
                result.accept(add)

            }
            .disposed(by: disposeBag)

        return Output(results: result, selectResult: itemResult)
    }
}
