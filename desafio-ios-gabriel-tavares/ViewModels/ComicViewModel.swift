//
//  ComicViewModel.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//


import Foundation
import UIKit
import Kingfisher

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
    
    func thumbnail(imageView: UIImageView) -> UIImageView {
        imageView.layer.borderWidth = 2.0;
        imageView.layer.borderColor = CGColor.init(genericGrayGamma2_2Gray: 10.0, alpha: 1.0)
        imageView.layer.masksToBounds = true;
        if comic.thumbnail.path.hasSuffix("image_not_available") {
            imageView.image = UIImage(named: "placeholder.png")
            return imageView
        }
        imageView.kf.setImage(with: URL(string: comic.thumbnail.path+"."+comic.thumbnail.extension))
        return imageView
    }

}
