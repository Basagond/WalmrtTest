//
//  PlanetaryDomainModel.swift
//  WalmartTest
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import Foundation

class PlanetaryDomainModel:Codable {
    let date, explanation: String
    let title: String
    let url: String
    
    var localData:Data? = nil

    init(with dataModel:PlanetaryDataModel?) {
        self.date = dataModel?.date ?? ""
        self.explanation = dataModel?.explanation ?? ""
        self.title = dataModel?.title ?? ""
        self.url = dataModel?.url ?? ""
    }
}
