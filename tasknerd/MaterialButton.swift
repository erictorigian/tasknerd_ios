//
//  MaterialButton.swift
//  fambam
//
//  Created by Eric Torigian on 4/6/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.borderWidth = 1

        
        
    }

   
}
