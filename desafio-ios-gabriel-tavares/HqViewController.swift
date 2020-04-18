//
//  HqViewController.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 16/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit

class HqViewController: UIViewController {
    
    var listHqs = [HQQ]() {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.title = "\(self.listHqs.count) HQs found"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        /*let HqRequest = HqRequest()
        
        HqRequest.getHqs { [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let hqs):
                self?.listHqs = hqs
            }
        }*/
    }
    
    
}
