//
//  CharacterViewController.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var characterViewModel: CharacterViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Marvel Heroes List"
        let characterRequest = CharacterRequest()
        characterRequest.getCharactersByOffset(offset: 0) { [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let characters):
                self?.characterViewModel =  CharacterViewModel(characters: characters)
            }
        }
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let lines = characterViewModel?.lines {
            return lines
        }
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characters", for: indexPath) as! CharacterTableViewCell
        cell.name?.text = characterViewModel?.name(index: indexPath.row)
        if let viewModelImage = (characterViewModel?.thumbnail(imageView: cell.thumbnail, index: indexPath.row)) {
            cell.thumbnail = viewModelImage
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "characterDetail") {
            let index = tableView.indexPathForSelectedRow?.row
            let viewController = segue.destination as? CharacterDetailViewController
            viewController!.character = characterViewModel?.characterAt(index: index!)
        }
    }
    
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        let offsetY = scrollView.contentOffset.y
        let scrollHeight = scrollView.frame.size.height

        let endScrolling = offsetY + scrollHeight

        if endScrolling >= scrollView.contentSize.height {
            let characterRequest = CharacterRequest()
            
            characterRequest.getCharactersByOffset(offset:self.characterViewModel!.lines+20) { [weak self] result in
                    switch result {
                    case .failure(let error):
                        print (error)
                    case .success(let characters):
                        self!.characterViewModel?.insertCharacteres(list: characters)
                    }
                }
                self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}




