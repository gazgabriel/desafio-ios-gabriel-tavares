//
//  CharacterRequest.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation
import CryptoKit

enum CharacterError:Error {
    case noData
    case canNotProcessData
}

struct CharacterRequest {
    let apiKey = "a9656274844c84e016ac7ec708b8c97f"
    let privateKey = "7ee55ae8c551672d1496be50389b9e32dd9e7c59"
    
    func getCharacters(completion: @escaping(Result<[Character], CharacterError>) -> Void) {
        let ts = Int.random(in: 100000 ... 999999)
        let urlString = "https://gateway.marvel.com/v1/public/characters?ts=\(String.init(ts))&apikey=\(apiKey)&hash=\(MD5(string: String.init(ts)+privateKey+apiKey))"
        let url = URL(string: urlString)!
        let request = URLSession.shared.dataTask(with: url) {data, _, _ in
            guard let json = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let charactersResponse = try decoder.decode(DataJSON.self, from: json)
                let characters = charactersResponse.data.results
                completion(.success(characters))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        request.resume()
    }
    

    func getCharactersByOffset(offset: Int, completion: @escaping(Result<[Character], CharacterError>) -> Void) {
        let ts = Int.random(in: 100000 ... 999999)
        let urlString = "https://gateway.marvel.com/v1/public/characters?ts=\(String.init(ts))&apikey=\(apiKey)&hash=\(MD5(string: String.init(ts)+privateKey+apiKey))&limit=20&offset=\(offset)"
        let url = URL(string: urlString)!
        let request = URLSession.shared.dataTask(with: url) {data, _, _ in
            guard let json = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let charactersResponse = try decoder.decode(DataJSON.self, from: json)
                let characters = charactersResponse.data.results
                completion(.success(characters))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        request.resume()
    }
}


// funcao MD5
// fonte: https://stackoverflow.com/a/56578995

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}
