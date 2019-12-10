//
//  Comic-API-Client.swift
//  Images-Lab
//
//  Created by Jaheed Haynes on 12/10/19.
//  Copyright © 2019 Jaheed Haynes. All rights reserved.
//

import Foundation

struct ComicAPIClient {
    
    static func getComic(for comicNum: Int, completion: @escaping (Result<Comic, AppError>) ->()) {
        
        let endpointURLString = "https://xkcd.com/\(comicNum)/info.0.json"
        
        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                
                do{
                    let comicQuery = try JSONDecoder().decode(Comic.self, from: data)
                    let comics = comicQuery
                    completion(.success(comics))
                    
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
