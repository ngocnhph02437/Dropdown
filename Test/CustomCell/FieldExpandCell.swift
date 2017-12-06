//
//  FieldExpand.swift
//  Test
//
//  Created by Nguyen Huu Ngoc on 12/4/17.
//  Copyright © 2017 Nguyen Huu Ngoc. All rights reserved.
//

import Foundation
import UIKit
class FieldExpandCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnExpand: UIButton!

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
