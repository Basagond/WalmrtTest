//
//  APIClinet.swift
//  WalmartTest
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import Foundation

import Foundation

enum ServiceResult<T> {
    case success(_ dataModel:T?)
    case failure(_ error:String)
}

enum CustomeError: Error {
    case nwError
    case other(_ error:String)
}

typealias CompletionHandler = (Result<Data, CustomeError>) -> Void
typealias ServiceCompletionHandler<T> = (ServiceResult<T>) -> Void


class APIClient {
    
    
    static func fireRequest(with request:URLRequest, completionHanlde: @escaping CompletionHandler) {

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completionHanlde(.failure(.other("error:\(error?.localizedDescription ?? "")")))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<299) ~= response.statusCode else {
                completionHanlde(.failure(.other("Error:Http response error")))
                return
            }
            
            
            guard let data = data else {
                completionHanlde(.failure(.other("Error: Empty data")))
                return
            }
            
            completionHanlde(.success(data))
        }
        task.resume()
    }
    
}
