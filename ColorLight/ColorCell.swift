//
//  ColorCell.swift
//  ColorLight
//
//  Created by Justin on 3/27/20.
//  Copyright © 2020 justncode LLC. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    
    var color: Color? {
        didSet {
            guard let color = color else { return }
            
            containerView.backgroundColor = color.uiColor
        }
    }
}
