//
//  MockLocalFileManager.swift
//  WalmartTestTests
//
//  Created by Basagond Mugganavar on 26/03/23.
//

import Foundation
@testable import WalmartTest
import UIKit

class MockLocalFileManager: LocalFileManagerProtocol {
    func deleteTheOldFile() {
        
    }
    
    func saveImageToFile(with model: WalmartTest.PlanetaryDomainModel) {
        
    }
    
    func readFromFile() -> WalmartTest.PlanetaryDomainModel? {
        let data = PlanetaryDomainModel(with: PlanetaryStubGenerator().getData())
        let img = UIImage(named: "icon")
        data.localData = img?.pngData()
        return data
    }
}
