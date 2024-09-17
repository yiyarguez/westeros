//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Kary Rguez on 16/09/24.
//

import UIKit


// TODO: - Investigar que es AnyObject
// AnyObject lo usamos para decirle al complilador que este protocol solo lo pueden usar reference types
// no value types - es decir con una struct no se podría
protocol FavouriteHouseDelegate: AnyObject {
    
    func didToggleFavourite(for house: House)
    
}

final class HouseDetailViewController: UIViewController {
    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var houseNameLabel: UILabel!
    
    // Goal: Pasar un objeto de tipo casa para representar los parámetros de la casa, para poder
    // representarlo en pantalla
    
    
    private let house: House
    private var isFavourite: Bool
    
    // TODO: - Investigar que es weak (sirve para gestionar la memoria)
    weak var favouriteHouseDelegate: FavouriteHouseDelegate?
    
    init(house: House, isFavourite: Bool) {
        self.house = house
        self.isFavourite = isFavourite
        
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
        navigationItem.rightBarButtonItem = makeRightBarButtonItem()
    }
    
    func makeRightBarButtonItem() -> UIBarButtonItem {
        UIBarButtonItem(
            image: makeFavouriteStar(isFavourite: isFavourite),
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
        isFavourite.toggle()
        favouriteHouseDelegate?.didToggleFavourite(for: house)
        navigationItem.setRightBarButton(makeRightBarButtonItem(), animated: true)
        
        // TODO: - Investigar el NotificationCenter y su método post
        // Nota: No tiene nada que ver con las notificaciones(baners) que nos muestran las aplicaciones por lo general.
        // Está relacionado con el patrón OBSERVER
        // Aquí estamos enviando la información
        NotificationCenter.default.post(
            name: .didToggleFavourite,
            object: nil,
            userInfo: ["house": house]
        )
    }
    
    // Método para mostrar una estrella o la otra dependiendo de si es favorito o no
    func makeFavouriteStar(isFavourite: Bool) -> UIImage? {
        isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
}

