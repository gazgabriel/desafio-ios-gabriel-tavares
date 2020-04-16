//
//  character.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation

// mapeamento da estrutura de retorno JSON

struct Results: Decodable {
    var results:Characters
}

struct Characters: Decodable {
    var characters:[Charcater]
}

struct Charcater: Decodable {
    var name:String
    var image:Image
}

struct Image: Decodable {
    var path:String
    var fileExtension:String
}

