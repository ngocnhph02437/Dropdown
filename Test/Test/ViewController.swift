//
//  ViewController.swift
//  Test
//
//  Created by Nguyen Huu Ngoc on 12/4/17.
//  Copyright © 2017 Nguyen Huu Ngoc. All rights reserved.
//

import UIKit

protocol Row {
    
    func title() -> String
    
    func configurationFunctionAndIdentifier(_ owner: ViewController) -> (((UITableViewCell, IndexPath) -> UITableViewCell),String)
    
    func rowHeight() -> CGFloat
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: Enum representing our table data and organization
    //Enum || Section TableView
    enum Section : Int {
        case basics = 0
        case services = 1
        case location = 2
        
        static let allValues = [Section.basics, Section.services, Section.location]
        
        func title() -> String? {
            switch self {
            case .basics:
                return "Basic Information"
            case .services:
                return "Service & Repair Capabilities"
            case .location:
                return "Preferred Job Location"
            }
        }
        
        func caseForRow(_ row: Int) -> Row? {
            switch self {
            case .basics:
                return SectionBasicRows(rawValue: row)
            case .services:
                return SectionServiceRows(rawValue: row)
            case .location:
                return SectionLocationRows(rawValue: row)
            default:
                return SectionBasicRows(rawValue: row)
            }
        }
        func headerHeight() -> CGFloat {
            return 50
        }
        
        func headerView(_ tableView: UITableView) -> UIView? {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionFormCell.identifier) as! SectionFormCell
            if let sectionName = self.title() {
                header.lblSection.text = sectionName
                header.contentView.backgroundColor = .white
            }
            return header
        }
    }
    
    // Section Basic Rows
    enum SectionBasicRows: Int, Row {
        
        case fullname = 0
        case address = 1
        case phone = 2
        case nric = 3
        
        static let allValues = [SectionBasicRows.fullname, SectionBasicRows.address,SectionBasicRows.phone, SectionBasicRows.nric]
        
        func configurationFunctionAndIdentifier(_ owner: ViewController) -> (((UITableViewCell, IndexPath) -> UITableViewCell),String) {
            switch self {
            case .fullname:
                return (owner.configureFullNameCell, FieldUserNameCell.identifier)
            case .address, .phone, .nric:
                return (owner.configureTextFieldCell, FieldEditTextCell.identifier)
            }
        }
        func title() -> String {
            
            switch self {
            case .fullname:
                return "Firstname *"
            case .address:
                return "Address *"
            case .phone:
                return "Mobile Phone *"
            case .nric:
                return "NRIC *"
            }
        }
        func rowHeight() -> CGFloat {
            switch self {
            case .fullname:
                return 76
            case .address, .nric, .phone:
                return 76
            }
        }
        
    }
    
    // Section Service Rows
    enum SectionServiceRows: Int, Row {
        
        case category = 0
        case serviceType = 1
        
        static let allValues = [SectionServiceRows.category, SectionServiceRows.serviceType]
        
        func configurationFunctionAndIdentifier(_ owner: ViewController) -> (((UITableViewCell, IndexPath) -> UITableViewCell),String) {

                return (owner.configureDropDownCell, FieldExpandCell.identifier)
    
        }
        func title() -> String {
            
            switch self {
            case .category:
                return "Category *"
            case .serviceType:
                return "Service Type *"
            }
        }
        func rowHeight() -> CGFloat {
            return 76
        }
        
    }
    // Section Location Rows
    enum SectionLocationRows: Int, Row {
        
        case location = 0
        
        static let allValues = [SectionLocationRows.location]
        
        func configurationFunctionAndIdentifier(_ owner: ViewController) -> (((UITableViewCell, IndexPath) -> UITableViewCell),String) {
            
            return (owner.configureDropDownCell, FieldExpandCell.identifier)
            
        }
        func title() -> String {
            return "Location *"
        }
        func rowHeight() -> CGFloat {
            return 76
        }
        
    }


    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: FieldEditTextCell.identifier, bundle: nil), forCellReuseIdentifier: FieldEditTextCell.identifier)
        tableView.register(UINib(nibName: FieldUserNameCell.identifier, bundle: nil), forCellReuseIdentifier: FieldUserNameCell.identifier)
        tableView.register(UINib(nibName: FieldExpandCell.identifier, bundle: nil), forCellReuseIdentifier: FieldExpandCell.identifier)
        tableView.register(UINib(nibName: SectionFormCell.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: SectionFormCell.identifier)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: TableView delegate, datasource and configure method
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allValues.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionCase = Section.allValues[section]
        switch sectionCase {
        case .basics:
            return SectionBasicRows.allValues.count
        case .services:
            return SectionServiceRows.allValues.count
        case .location:
            return SectionLocationRows.allValues.count

        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionCase = Section.allValues[indexPath.section]
        if let rowCase = sectionCase.caseForRow(indexPath.row) {
            let (configFunction, identifier) = rowCase.configurationFunctionAndIdentifier(self)
            return configureCellForIndentifier(tableView, cellIdentifier: identifier, indexPath: indexPath, configurationFunction: configFunction)
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionCase = Section.allValues[indexPath.section]
        if let rowCase = sectionCase.caseForRow(indexPath.row){
            return rowCase.rowHeight()
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return Section(rawValue: section)?.headerView(tableView)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    //MARK: Cell Configure Function
    func configureCellForIndentifier(_ tableView: UITableView, cellIdentifier: String, indexPath: IndexPath, configurationFunction:(UITableViewCell, IndexPath) -> UITableViewCell) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        return configurationFunction(cell, indexPath)
    }
    
    func configureTextFieldCell(_ cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let sectionCase = Section.allValues[indexPath.section]
        if let lbName = cell as? FieldEditTextCell, let rowCase = sectionCase.caseForRow(indexPath.row) {
            lbName.lblTitle.text = rowCase.title()
            return lbName
        }
        return cell
    }
    func configureFullNameCell(_ cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        if let lbName = cell as? FieldUserNameCell{
            return lbName
        }
        return cell
    }
    func configureDropDownCell(_ cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let sectionCase = Section.allValues[indexPath.section]
        if let lbName = cell as? FieldExpandCell, let rowCase = sectionCase.caseForRow(indexPath.row) {
            lbName.lblTitle.text = rowCase.title()
            return lbName
        }
        return cell
    }
}



