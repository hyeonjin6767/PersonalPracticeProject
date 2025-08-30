//
//  FirstViewController.swift
//  PersonalPracticeProject
//
//  Created by 박현진 on 8/30/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FirstViewController: UIViewController {

    let anythingTableview = {
        let tableView = UITableView()
        
        tableView.register(FirstTableViewCell.self, forCellReuseIdentifier: FirstTableViewCell.identifier)
        tableView.backgroundColor = .lightGray
        return tableView
    }()
//    lazy var anythingCollectionview = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    
    let anythingCollectionview = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (10 * 2) - (5 * 3)
        layout.itemSize = CGSize(width: cellWidth/3, height: 30)
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 5
//        layout.minimumInteritemSpacing = 5
        collectionView.collectionViewLayout = layout
        collectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: FirstCollectionViewCell.identifier)
        collectionView.backgroundColor = .brown
        return collectionView
    }()
    
    private let disposeBag = DisposeBag()
    
//    let items = Observable.just(["라이브","코딩","연습","중"])
    let items: Observable<[String]> = Observable.just(["라이브","코딩","연습","중"])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        bind()

    }
    /**
    Binds sequences of elements to collection view items.
    
    - parameter source: Observable sequence of items.
    - parameter cellFactory: Transform between sequence elements and view cells.
    - returns: Disposable object that can be used to unbind.
     
     Example
    
         let items = Observable.just([
             1,
             2,
             3
         ])

         items
         .bind(to: collectionView.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NumberCell
             cell.value?.text = "\(element) @ \(row)"
             return cell
         }
         .disposed(by: disposeBag)
    */
    /**
    Binds sequences of elements to collection view items.
    
    - parameter cellIdentifier: Identifier used to dequeue cells.
    - parameter source: Observable sequence of items.
    - parameter configureCell: Transform between sequence elements and view cells.
    - parameter cellType: Type of collection view cell.
    - returns: Disposable object that can be used to unbind.
     
     Example

         let items = Observable.just([
             1,
             2,
             3
         ])

         items
             .bind(to: collectionView.rx.items(cellIdentifier: "Cell", cellType: NumberCell.self)) { (row, element, cell) in
                cell.value?.text = "\(element) @ \(row)"
             }
             .disposed(by: disposeBag)
    */
    
    func bind() {
        
//        let a = Observable<[String]>.just(["라이브","코딩","연습","중"])
//        print(a)
        
        let itemss = Observable.just(["1","2","3","4","5","6"])

        
        
        items
            .bind(to: anythingTableview.rx.items) { (tableview, row, element) in
                let cell = tableview.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier) as! FirstTableViewCell
                cell.anythingLabel.text = element
                return cell
            }
            .disposed(by: disposeBag)
        
//        itemss
//            .bind(to: anythingCollectionview.rx.items) { (collectionview, row, element) in
//                let indexPath = IndexPath(row: row, section: 0)
//                let cell = collectionview.dequeueReusableCell(withReuseIdentifier: FirstCollectionViewCell.identifier, for: indexPath) as! FirstCollectionViewCell
//                cell.anythingLabel.text = element
//                return cell
//            }
//            .disposed(by: disposeBag)
        itemss
            .bind(to: anythingCollectionview.rx.items(cellIdentifier: FirstCollectionViewCell.identifier, cellType: FirstCollectionViewCell.self)) { (row, element, cell) in
                cell.anythingLabel.text = element
                
            }
            .disposed(by: disposeBag)
//        
        
    }

    private func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(anythingTableview)
        view.addSubview(anythingCollectionview)
        
        anythingTableview.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.height.equalTo(100)

        }
        anythingCollectionview.snp.makeConstraints { make in
            make.top.equalTo(anythingTableview.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
    }
    
   
    
}
