//
//  ComicRequest.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 16/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation
import CryptoKit

enum ComicError:Error {
    case noData
    case canNotProcessData
}

struct ComicRequest {
    let apiKey = "a9656274844c84e016ac7ec708b8c97f"
    let privateKey = "7ee55ae8c551672d1496be50389b9e32dd9e7c59"
    let url:URL
    
    init(characterID:Int) {
        let ts = Int.random(in: 100000 ... 999999)
        let urlString = "https://gateway.marvel.com/v1/public/characters/\(String.init(characterID))/comics?ts=\(String.init(ts))&apikey=\(apiKey)&hash=\(MD5(string: String.init(ts)+privateKey+apiKey))&limit=100&offset=0"
        print(urlString)
        self.url = URL(string: urlString)!
    }
    
    
    func getComics(completion: @escaping(Result<[Comic], ComicError>) -> Void) {
        let request = URLSession.shared.dataTask(with: url) {data, _, _ in
            guard let json = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let comicsResponse = try decoder.decode(DataJSON_Comic.self, from: json)
                let hqs = comicsResponse.data?.results
                completion(.success(hqs!))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        request.resume()
    }
}
