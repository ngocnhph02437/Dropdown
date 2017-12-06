//
//  FieldUserName.swift
//  Test
//
//  Created by Nguyen Huu Ngoc on 12/4/17.
//  Copyright © 2017 Nguyen Huu Ngoc. All rights reserved.
//

import Foundation
import UIKit
class FieldUserNameCell: UITableViewCell{
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
