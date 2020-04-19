//
//  ComicViewModel.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//


import Foundation
import UIKit

struct ComicViewModel {
    
    let comic:Comic
    
    
    init (comic: Comic) {
        self.comic = comic
    }
    
    var title:String {
        return comic.title
    }
    
    var description:String? {
        if comic.description?.count ?? 0 > 0 {
            return comic.description
        }
        return "Description not found."
    }
    
    var thumbnail: URL? {
        return URL(string: comic.thumbnail.path+"."+comic.thumbnail.extension)
    }

}
