//
//  EventTableViewCell.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var eventTableViewCellViewModel = EventTableViewCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventImageView.image = UIImage(named: "empty_image")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getImageFromURL(url: URL) {
        eventTableViewCellViewModel.getData(from: url) { (data, response, error) in
            guard let data = data, error == nil else {
                self.setImage(image: UIImage(named: "empty_image"))
                return
            }
            
            self.setImage(image: UIImage(data: data))
        }
    }
    
    private func setImage(image: UIImage?) {
        DispatchQueue.main.async() {
            self.eventImageView.image = image
        }
    }
}
