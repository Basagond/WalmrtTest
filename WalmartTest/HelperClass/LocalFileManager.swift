//
//  LocalFileManager.swift
//  WalmartTest
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import Foundation

class LocalFileManager {
    static var sharedInstance = LocalFileManager()
    
    private let fileName:String = "myJsonData"

    private var path:URL {
        return FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent(fileName)
    }
    
    func saveImageToFile(with model:PlanetaryDomainModel) {
//        let localImage = LocalImage(date: date, imageData: data)
        let json = convertBodyParams(details: model)
        if let jsonData = try? JSONSerialization.data(withJSONObject: json) {
            do {
                try jsonData.write(to: path)
            } catch {
                print("Unable to save the file")
            }
        }
    }
    
    private func convertBodyParams<T: Codable>(details: T) -> [String: Any] {
        if let encodedData = try? JSONEncoder().encode(details),
           let jsonData = try? JSONSerialization.jsonObject(with: encodedData, options: .mutableContainers),
           let params = jsonData as? [String : Any] {
            return params
        }
        return [:]
    }
    
    
    func readFromFile() -> PlanetaryDomainModel? {
        do {
            // Get the saved data
            let savedData = try Data(contentsOf: path)
            return parseResponse(from: savedData, responseType: PlanetaryDomainModel.self)
        } catch {
            // Catch any errors
            print("Unable to read the file")
        }
        return nil
    }
    
    func parseResponse<T: Decodable>(from jsonData:Data, responseType: T.Type) -> T? {
        guard let parsedModels = try? JSONDecoder().decode(responseType.self, from: jsonData) else { return nil }
        return parsedModels
    }
    
    
    func deleteTheOldFile() {
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            // Catch any errors
            print("Unable to delete the file")
        }
    }
}
