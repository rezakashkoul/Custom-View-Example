//
//  TableViewCell.swift
//  mySampleTest
//
//  Created by Reza Kashkoul on 12/12/1401.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var parentView: CustomView!
    
    static let identifier = "TableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}

//MARK: - Setup
extension TableViewCell {
    
    func setup(_ config: CustomView.Config) {
        parentView.configView(config)
    }
}
