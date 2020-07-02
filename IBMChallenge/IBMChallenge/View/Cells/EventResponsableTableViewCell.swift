//
//  EventResponsableTableViewCell.swift
//  IBMChallenge
//
//  Created by Ruyther on 02/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

// MARK: -

class EventResponsableTableViewCell: UITableViewCell {

    // MARK: - Properties -
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    // MARK: - View Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Private Methods -
    
    private func configImageView() {
        userImage.layer.masksToBounds = false
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.clipsToBounds = true
    }
    
}
