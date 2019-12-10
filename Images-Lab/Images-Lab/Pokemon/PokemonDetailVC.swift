//
//  PokemonDetailVC.swift
//  Images-Lab
//
//  Created by Jaheed Haynes on 12/10/19.
//  Copyright © 2019 Jaheed Haynes. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weaknessLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    
    var pokemon: Cards?
    
//---------------------------------------------------------

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


//---------------------------------------------------------

    
    
    func updateUI(){
        guard let pokemonChar = pokemon else {
            return
        }
        nameLabel.text = pokemonChar.name
        typeLabel.text = "\(pokemonChar.types?.first ?? "") type"
        weaknessLabel.text = "Weaknesses: \(pokemonChar.weaknesses?.first?.type ?? "") Damage: \(pokemonChar.weaknesses?.first?.value ?? "")"
        setLabel.text = (pokemonChar.set)
        
        NetworkHelper.shared.performDataTask(with: pokemonChar.imageUrlHiRes) { [unowned self] (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: image)
                }
            }
        }
    }
}
