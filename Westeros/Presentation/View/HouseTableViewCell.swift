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
    
    // MARK: - Configuration
    func configure(with house: House) {
        
        // RawValue lo utilizamos para obtener la representación del String
        houseLabel.text = house.rawValue
        
        guard let imageURL = house.imageURL else {
            return
        }
        houseImageView.setImage(url: imageURL)
    }
  
    
}
