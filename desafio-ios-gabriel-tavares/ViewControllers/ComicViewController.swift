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
    @IBOutlet weak var activityIdicator: UIActivityIndicatorView!
    
    
    var characterID:Int?
    var comicViewModel:ComicViewModel?
    
    var listComics = [Comic]() {
        didSet {
            DispatchQueue.main.async {
                self.HighPiceComic()
                self.activityIdicator.stopAnimating()
                self.activityIdicator.isHidden = true
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIdicator.startAnimating()
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
        var highPrice = self.listComics[0].prices[0]
        var highPriceComic = self.listComics[0]
        for comic in self.listComics {
            let prices = comic.prices
            for price in prices {
                if price.price > highPrice.price {
                    highPrice = price
                    highPriceComic = comic
                }
            }
        }
        
        self.comicViewModel = ComicViewModel(comic: highPriceComic)
        
        self.name?.text = comicViewModel?.title
        self.desc?.text = comicViewModel?.description
        self.price?.text = "Price: \(String.init(highPrice.price)) USD"
        self.thumbnail = comicViewModel?.thumbnail(imageView: self.thumbnail!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
