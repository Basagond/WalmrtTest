//
//  PlanetaryRepository.swift
//  WalmartTest
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import Foundation
class PlanetaryRepository {
    private var planetaryProtocol: PlanetaryServiceProtocol
    init(with planetaryProtocol: PlanetaryServiceProtocol) {
        self.planetaryProtocol = planetaryProtocol
    }
}


extension PlanetaryRepository: PlanetaryUseCase {
    func getPlanetaryData(completionHandler: @escaping ServiceCompletionHandler<PlanetaryDomainModel>) {
        planetaryProtocol.getPlanetaryData { result in
            switch result {
            case .success(let model) :
                let planetaryDomainModel = PlanetaryDomainModel(with: model)
                completionHandler(ServiceResult.success(planetaryDomainModel))
            case .failure(let error) :
                completionHandler(ServiceResult.failure(error.description))
            }
        }
    }
}
