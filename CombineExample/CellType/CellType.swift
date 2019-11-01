//
//  CellType.swift
//  CombineExample
//
//  Created by ryuickhwan on 2019/10/31.
//  Copyright © 2019 ryuickhwan. All rights reserved.
//

enum CellType: CaseIterable {
    case ImageLoad
    case Button
    
    var identifier: String {
        return "cell"
    }
}
