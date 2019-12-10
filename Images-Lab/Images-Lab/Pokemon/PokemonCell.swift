//
//  TableViewCell.swift
//  Images-Lab
//
//  Created by Jaheed Haynes on 12/10/19.
//  Copyright © 2019 Jaheed Haynes. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokemonThumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Cards?
    
//---------------------------------------------------------

    
    func configureCell(for poke: Cards){
        nameLabel.text = poke.name
        NetworkHelper.shared.performDataTask(with: poke.imageUrl) { [unowned self] (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.pokemonThumbImage.image = UIImage(data: image)
                }
            }
        }
    }
}
