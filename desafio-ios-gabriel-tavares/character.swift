//
//  character.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation

// mapeamento da estrutura de retorno JSON

struct DataJSON: Decodable {
    var data:Results
}

struct Results: Decodable {
    var results:[Character]
}

struct Character: Decodable {
    var name:String
    var description:String
    var thumbnail:Thumbnail
}

struct Thumbnail: Decodable {
    var path:String
    var `extension`:String
}

