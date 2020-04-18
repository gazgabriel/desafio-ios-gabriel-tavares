//
//  Comic.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation

// mapeamento da estrutura de retorno JSON

struct DataJSON_Comic: Decodable {
    var data:Results_Comic
}

struct Results_Comic: Decodable {
    var total:Int
    var results:[Comic]?
}

struct Comic: Decodable {
    var id:Int
    var title:String
    var description:String?
    var thumbnail:Thumbnail
    var prices:[Prices]
    
}

struct Prices: Decodable {
    var type:String
    var price:Double
}

struct Thumbnail_Comic: Decodable {
    var path:String
    var `extension`:String
}


