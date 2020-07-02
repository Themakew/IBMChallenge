//
//  EventDetailViewController.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    var id: String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init?(coder: NSCoder, id: String) {
        self.id = id
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
