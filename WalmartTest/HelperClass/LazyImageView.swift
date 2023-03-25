//
//  LazyImageView.swift
//  WalmartTest
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import Foundation
import UIKit

class LazyImageView: UIImageView {
        
    func loadImage(from model:PlanetaryDomainModel) {
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: model.url), let imageData = try? Data(contentsOf: url) {
                debugPrint("image downloaded from server...")
                model.localData = imageData
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        LocalFileManager.sharedInstance.saveImageToFile(with: model)
                        self?.image = image
                    }
                }
            }
        }
    }
}



