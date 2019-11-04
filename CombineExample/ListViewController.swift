//
//  ListViewController.swift
//  CombineExample
//
//  Created by ryuickhwan on 2019/10/30.
//  Copyright © 2019 ryuickhwan. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cells = BehaviorRelay<[CellType]>(value: CellType.allCases)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cells.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: ExampleCell.self)) { index, type, cell in
            cell.label.text = type.title
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let type = self?.cells.value[indexPath.row] else { return }
            var viewController: UIViewController!
            
            switch type {
            case .ImageLoad:
                viewController = ImageLoadViewController.instantiate()
            }
            self?.tableView.deselectRow(at: indexPath, animated: true)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }).disposed(by: disposeBag)
    }
}
