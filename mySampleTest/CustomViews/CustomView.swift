//
//  CustomView.swift
//  mySampleTest
//
//  Created by Reza Kashkoul on 12/12/1401.
//

import UIKit

class CustomView: NibView {
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var parentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private var config: Config! {
        didSet {
            DispatchQueue.main.async {[self] in
                setupView()
                layoutIfNeeded()
            }
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

//MARK: - Setup Views
extension CustomView {
    
    func configView(_ config: Config) {
        self.config = config
        setupView()
    }
    
    private func setupView() {
        self.headerLabel.text = config.header
        self.titleLabel.text = config.title
    }
}

//MARK: - Configure
extension CustomView {
    
    struct Config {
        let header: String
        var title: String
        let items: [String]
    }
}
