//
//  TodoCell.swift
//  tasknerd
//
//  Created by Eric Torigian on 8/10/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var usernameField: UILabel!
    
    @IBOutlet weak var todoNameField: UILabel!
    @IBOutlet weak var todoDetailField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
