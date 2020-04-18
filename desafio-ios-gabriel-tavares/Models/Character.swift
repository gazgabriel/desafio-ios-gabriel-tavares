//
//  Character.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation

// mapeamento da estrutura de retorno JSON

struct DataJSON_Characters: Decodable {
    var data:Results_Characters
}

struct Results_Characters: Decodable {
    var total:Int
    var results:[Character]
}

struct Character: Decodable {
    var id:Int
    var name:String
    var description:String?
    var thumbnail:Thumbnail
    var comics: comicsByCharacter
}

struct comicsByCharacter: Decodable {
    var available: Int
}

struct Thumbnail: Decodable {
    var path:String
    var `extension`:String
}

