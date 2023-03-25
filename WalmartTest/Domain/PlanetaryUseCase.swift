//
//  PlanetaryUseCase.swift
//  WalmartTest
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import Foundation

protocol PlanetaryUseCase {
    func getPlanetaryData(completionHandler: @escaping ServiceCompletionHandler<PlanetaryDomainModel>)
}
