//
//  EventTableViewCell.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

// MARK: -

class EventTableViewCell: UITableViewCell {
    
    // MARK: - Properties -
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    var eventTableViewCellViewModel = EventTableViewCellViewModel()
    
    // MARK: - View Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventImageView.image = UIImage(named: "empty_image")
        locationLbl.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Internal Methods -
    
    func getImageFromURL(url: URL) {
        eventTableViewCellViewModel.getData(from: url) { (data, response, error) in
            guard let data = data, error == nil else {
                self.setImage(image: UIImage(named: "empty_image"))
                return
            }
            
            self.setImage(image: UIImage(data: data))
        }
    }
    
    func getLocation(latitude: Double, longitude: Double) {
        eventTableViewCellViewModel.getLocationName(latitude: latitude, longitude: longitude) { (location, error) in
            if error == nil {
                self.setLocationLabel(location: location)
            } else {
                self.setLocationLabel(location: "")
            }
        }
    }
    
    // MARK: - Private Methods -
    
    private func setImage(image: UIImage?) {
        DispatchQueue.main.async() {
            self.eventImageView.image = image
        }
    }
    
    private func setLocationLabel(location: String) {
        DispatchQueue.main.async() {
            self.locationLbl.text = location
            self.locationLbl.setNeedsDisplay()
        }
    }
}
