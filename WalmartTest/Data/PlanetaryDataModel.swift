//
//  PlanetaryDataModel.swift
//  WalmartTest
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import Foundation
class PlanetaryDataModel: Codable {
    let copyright, date, explanation: String?
    let hdurl: String?
    let mediaType, serviceVersion, title: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
