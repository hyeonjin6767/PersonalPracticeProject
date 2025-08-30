//
//  SecondViewController.swift
//  PersonalPracticeProject
//
//  Created by 박현진 on 8/30/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SecondViewController: UIViewController {

    let number1 = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.text = "1"
        return textField
    }()
    let number2 = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.text = "2"
        return textField
    }()
    let number3 = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.text = "3"
        return textField
    }()
    let result = {
        let label = UILabel()
        label.textAlignment = .right
        label.resignFirstResponder()
        return label
    }()
    let disposeBag = DisposeBag()
    
    let viewModel = SecondViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
        bind()
    }
    
    func bind() {
        
        
//        let a = number1.rx.text.orEmpty
        
        let input = SecondViewModel.Input(inputNum1: number1.rx.text.orEmpty,
                                          inputNum2: number2.rx.text.orEmpty,
                                          inputNum3: number3.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.plusResult
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
        
        
        

        
        
//        Observable
//            .combineLatest() {
//                
//            }
        
        
        
        Observable
            .combineLatest(number1.rx.text.orEmpty,
                           number2.rx.text.orEmpty,
                           number3.rx.text.orEmpty
            ){ textValue1, textValue2, textValue3 -> Int in
                return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }
            .map { $0.description }
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
//        
    }
    

    private func configure() {
        view.backgroundColor = .white
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(result)
        view.endEditing(true)

        number1.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        number2.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(number1.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        number3.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(number2.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        result.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(number3.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
        }

    }
}
