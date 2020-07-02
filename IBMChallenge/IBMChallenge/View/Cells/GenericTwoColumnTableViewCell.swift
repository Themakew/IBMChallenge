//
//  GenericTwoColumnTableViewCell.swift
//  IBMChallenge
//
//  Created by Ruyther on 02/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

class GenericTwoColumnTableViewCell: UITableViewCell {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(titleText: String, descriptionText: String) {
        self.titleText.text = titleText
        self.descriptionLbl.text = descriptionText
    }
    
    func setVerticalTextFieldAlignment(verticalAlignment: UIControl.ContentVerticalAlignment) {
        titleText.contentVerticalAlignment = verticalAlignment
    }
    
    func setHorizontalTextFieldAlignment(horizontalAlignment: UIControl.ContentHorizontalAlignment) {
        titleText.contentHorizontalAlignment = horizontalAlignment
    }
}
