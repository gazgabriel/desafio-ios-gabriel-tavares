//
//  ComicViewController.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 16/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController {
    
    @IBOutlet weak var thumbnail: UIImageView?
    @IBOutlet weak var price: UILabel?
    @IBOutlet weak var name: UILabel!    
    @IBOutlet weak var desc: UILabel!
    
    
    
    var characterID:Int?
    
    var listComics = [Comic]() {
        didSet {
            DispatchQueue.main.async {
                self.HighPiceComic()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let comicRequest = ComicRequest(characterID: characterID!)
        self.navigationItem.title = "High Price Comic"
        comicRequest.getComics{ [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let comics):
                self?.listComics = comics
            }
        }
    }

    func HighPiceComic() {
        var highPrice = 0.0
        var highPriceComic = self.listComics[0]
        for comic in self.listComics {
            let prices = comic.prices
            for price in prices {
                if price.price > highPrice {
                    highPrice = price.price
                    highPriceComic = comic
                }
            }
        }
        self.name?.text = highPriceComic.title
        self.desc?.text = highPriceComic.description
        self.price?.text = String.init(highPrice)
        
        let url = URL(string: highPriceComic.thumbnail.path+"."+highPriceComic.thumbnail.extension)
        
        
        getData(from: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.thumbnail?.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
           URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
       }
}
