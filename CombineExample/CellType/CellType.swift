//
//  CellType.swift
//  CombineExample
//
//  Created by ryuickhwan on 2019/10/31.
//  Copyright © 2019 ryuickhwan. All rights reserved.
//

import UIKit
import Reusable

enum CellType: Int, CaseIterable {
    case ImageLoad = 0
    
    var title: String {
        switch self {
        case .ImageLoad:
            return "ImageLoader Example"
        }
    }
}
