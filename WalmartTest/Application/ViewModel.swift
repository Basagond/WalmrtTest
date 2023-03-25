//
//  ViewModel.swift
//  WalmartTest
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import Foundation

protocol ListServiveDelegates {
    func localImageLoaded(error:String?)
    func serverDataSucces()
    func errorAccored(error:String)
}

class ViewModel {
    private var planetaryUseCase: PlanetaryUseCase
    var dataModel:PlanetaryDomainModel?
    var delegate:ListServiveDelegates!
    
    init(with useCase: PlanetaryUseCase) {
        planetaryUseCase = useCase
    }
    
    var title:String? {
        return dataModel?.title
    }
    
    var explanation:String? {
        return dataModel?.explanation
    }
    
    var imageUrl:String? {
        return dataModel?.url
    }
    
    var imageDate:String? {
        return dataModel?.date
    }
    
    var imageData:Data? {
        return dataModel?.localData
    }
    
    private var getTodayFormattedDate:String {
        return  Date().getFormattedDate(format: "yyyy-MM-dd")
    }
    
    func loadImage()  {
        if let cachedImage = LocalFileManager.sharedInstance.readFromFile(), cachedImage.date == getTodayFormattedDate {
            debugPrint("image loaded from cache")
            dataModel = cachedImage
            delegate.localImageLoaded(error: nil)
        } else {
            if InternetConnectionManager.isConnectedToNetwork() {
                LocalFileManager.sharedInstance.deleteTheOldFile()
                getImageFromServer()
            } else {
                delegate.localImageLoaded(error: "We are not connected to the internet, showing you the last image we have.")
            }
        }
    }
    
    private func getImageFromServer() {
        planetaryUseCase.getPlanetaryData { [weak self] result in
            switch result {
            case .success(let model) :
                self?.dataModel = model
                self?.delegate.serverDataSucces()
            case .failure(let errorString) :
                self?.delegate.errorAccored(error: errorString)
            }
        }
    }
}


extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

