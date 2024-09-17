//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Kary Rguez on 16/09/24.
//

import UIKit

final class HouseDetailViewController: UIViewController {
    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var houseNameLabel: UILabel!
    
    // Goal: Pasar un objeto de tipo casa para representar los parámetros de la casa, para poder
    // representarlo en pantalla
    
    
    private let house: House
    
    init(house: House) {
        self.house = house
        // TODO: - ¿Qué es nibName y bundle?
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) // El compilador no llamaría a este inicializador
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationItem()
    }
}

// MARK: - Configuración para mostrar image y label en la pantalla de detalles
// TODO: - Investigar como funcionan las extensiones y para que sirven

private extension HouseDetailViewController {
    func configureView() {
        houseNameLabel.text = house.rawValue
        
        // Desempaquetar la imageURL
        guard let imageURL = house.imageURL else {
            return
        }
        
        // Si, si puedo desempaquetar la imageURL
        houseImageView.setImage(url: imageURL)
    }
    
    func configureNavigationItem() {
        
        // Componente que aparece en el navigation bar en la parte derecha
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self, // self hace referencia a class HouseDetailViewController
            action: #selector(didTapFavouriteItem)
        )
    }
    
    // TODO: - Investigar más sobre que es el sender
    // sender es el componente que ejecuta la acción
    
    @objc // Se tiene que marcar en swift para que pueda interacturar objective-c con swift
          // Le decimos al compilador que el método está disponible en objective-c
    
    func didTapFavouriteItem(_ sender:Any) {
        print("Favourite tapped ⭐️")
    }
}

