//
//  PlanetaryService.swift
//  WalmartTest
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import Foundation

protocol PlanetaryServiceProtocol {
    func getPlanetaryData(completionHandler:@escaping ServiceCompletionHandler<PlanetaryDataModel>)
}

class PlanetaryService: BaseService { }

extension PlanetaryService: PlanetaryServiceProtocol {
    func getPlanetaryData(completionHandler:@escaping ServiceCompletionHandler<PlanetaryDataModel>) {
        let listUrl = "https://api.nasa.gov/planetary/apod?api_key=8QDRFhCwE6NY4qJQ1zmhtjc8nRW7Pe8KrJn50y8Q"
        makeRequest(with: listUrl, type: "GET", body: nil, henader: nil, responseType: PlanetaryDataModel.self, completionHandler: completionHandler)
    }
}
