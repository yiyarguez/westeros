//
//  HouseTableViewCell.swift
//  Westeros
//
//  Created by Kary Rguez on 12/09/24.
//

import UIKit

final class HouseTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    // Usando String(describing:) vamos a crear un String
    // de la siguiente forma "HouseTableViewCell"
    // static let identifier = "HouseTableViewCell"
    static let identifier = String(describing: HouseTableViewCell.self)
    
    // MARK: - Outlets

    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    // MARK: - Configuration
    func configure(with house: House, isFavourite: Bool) {
        
        // RawValue lo utilizamos para obtener la representación del String
        houseLabel.text = house.rawValue
        
        favouriteImageView.isHidden = !isFavourite
        
        guard let imageURL = house.imageURL else {
            return
        }
        houseImageView.setImage(url: imageURL)
    }
  
    
}
