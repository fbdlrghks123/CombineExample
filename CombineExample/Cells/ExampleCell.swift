//
//  ExampleCell.swift
//  CombineExample
//
//  Created by ryuickhwan on 2019/10/31.
//  Copyright © 2019 ryuickhwan. All rights reserved.
//

import UIKit

class ExampleCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func config(title: String) {
        label.text = title
    }
}
