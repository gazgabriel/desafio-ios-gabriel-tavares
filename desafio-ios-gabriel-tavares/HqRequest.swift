//
//  HqRequest.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 16/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation
import CryptoKit

enum HqError:Error {
    case noData
    case canNotProcessData
}

struct HqRequest {
    let apiKey = "a9656274844c84e016ac7ec708b8c97f"
    let privateKey = "7ee55ae8c551672d1496be50389b9e32dd9e7c59"
    let url:URL
    
    init(character:Int) {
        let ts = Int.random(in: 100000 ... 999999)
        let urlString = "https://gateway.marvel.com/v1/public/characters/\(String.init(character))/comics?ts=\(String.init(ts))&apikey=\(apiKey)&hash=\(MD5(string: String.init(ts)+privateKey+apiKey))"
        self.url = URL(string: urlString)!
    }
    
    
    func getHqs(completion: @escaping(Result<[HQQ], HqError>) -> Void) {
        let request = URLSession.shared.dataTask(with: url) {data, _, _ in
            guard let json = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let charactersResponse = try decoder.decode(DataJSON_HQ.self, from: json)
                let hqs = charactersResponse.data.results
                completion(.success(hqs))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        request.resume()
    }
}

// funcao MD5
// fonte: https://stackoverflow.com/a/56578995
/*
private func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}
*/
