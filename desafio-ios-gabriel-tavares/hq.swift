//
//  hq.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation

struct DataJSON_HQ: Decodable {
    var total:Int
    var data:Results_HQ
}

struct Results_HQ: Decodable {
    var results:[HQQ]
}

struct HQQ: Decodable {
    var id:Int
    var title:String
    var description:String
    var thumbnail:Thumbnail
    var prices:[Prices]
    
}

struct Prices: Decodable {
    var type:String
    var price:Double
}

struct Thumbnail_HQ: Decodable {
    var path:String
    var `extension`:String
}


