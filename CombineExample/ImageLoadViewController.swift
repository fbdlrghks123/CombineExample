//
//  ViewController.swift
//  CombineExample
//
//  Created by ryuickhwan on 2019/10/30.
//  Copyright © 2019 ryuickhwan. All rights reserved.
//

import UIKit
import Reusable
import Combine
import RxSwift
import RxCocoa

class ImageLoadViewController: UIViewController, StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    let imageUrl = "https://picsum.photos/1000"
    
    @IBOutlet weak var rxImageView: UIImageView!
    @IBOutlet weak var combineImageView: UIImageView!
    
    // Bag
    var cancellable: Cancellable?
    
    var disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadImageRx(url: imageUrl)
            .observeOn(MainScheduler.instance)
            .bind(to: rxImageView.rx.image)
            .disposed(by: disposeBag)
        
        cancellable = downloadImageCombine(url: imageUrl)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.combineImageView.image = $0 })
    }
    
    func downloadImageRx(url: String) -> Observable<UIImage?> {
        
        guard let url = URL(string: url) else { return .empty() }
        let urlRequest = URLRequest(url:url )
        
        return URLSession.shared.rx
            .data(request: urlRequest)
            .map { UIImage(data: $0) }
    }
    
    func downloadImageCombine(url: String) -> AnyPublisher<UIImage?, Error> {
        
        let urlRequest = URLRequest(url:URL(string: url)!)
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map { UIImage(data: $0.data) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

