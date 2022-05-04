//
//  CellLineModel.swift
//  IBMChallenge
//
//  Created by Ruyther on 02/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

protocol CellLineModel {}

struct MapLine: CellLineModel {
    var latitude: Double
    var longitude: Double
}

struct InfoLine: CellLineModel {
    var title: String
    var imageName: String
    var description: String
}

struct TwoColumnInfoLine: CellLineModel {
    var title: String
    var description: String
}
