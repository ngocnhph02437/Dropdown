//
//  SectionForm.swift
//  Test
//
//  Created by Nguyen Huu Ngoc on 12/4/17.
//  Copyright © 2017 Nguyen Huu Ngoc. All rights reserved.
//

import Foundation
import UIKit

class SectionFormCell: UITableViewHeaderFooterView {
    @IBOutlet weak var lblSection: UILabel!
    

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
