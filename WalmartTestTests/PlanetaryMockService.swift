//
//  PlanetaryMockService.swift
//  WalmartTestTests
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import Foundation
@testable import WalmartTest


class PlanetaryMockService: PlanetaryServiceProtocol {
    var planetaryCompletionHandler: ServiceCompletionHandler<PlanetaryDataModel>?
}


extension PlanetaryMockService {
    func getPlanetaryData(completionHandler: @escaping WalmartTest.ServiceCompletionHandler<WalmartTest.PlanetaryDataModel>) {
        planetaryCompletionHandler = completionHandler
        planetoryData(withStatus: true)
    }
    
    func planetoryData(withStatus success:Bool) {
        if success {
            if let data = PlanetaryStubGenerator().getData() {
                planetaryCompletionHandler?(ServiceResult.success(data))
            } else {
                planetaryCompletionHandler?(ServiceResult.failure("something error in data"))
            }
        } else {
            //something error in fetching order list
            planetaryCompletionHandler?(ServiceResult.failure("something error in fetching order list"))
        }
    }
}
