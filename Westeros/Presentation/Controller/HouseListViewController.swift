//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Kary Rguez on 12/09/24.
//

import UIKit

final class HouseListViewController: UITableViewController {
    

    
    // MARK: - Table View DataSource
    typealias DataSource = UITableViewDiffableDataSource<Int, House>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, House> // Actualiza datos
    
    // MARK: - Model
    private let houses: [House] = House.allCases
    private var favouriteHouses: [String: House] = [:]
    
    // Al declarar una variable como nula el compilador infiere que su valor inicial es 'nil'
    private var dataSource: DataSource?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Registrar la celda custom
        // Registramos la celda que hemos creado de forma personalizada
        tableView.register(
            // Instanciamos el archivo .xib a traves de su nombre
            UINib(nibName: HouseTableViewCell.identifier, bundle: nil),
            // Cada vez que TableView se encuentre este identificador
            // tiene que instancias el .xib que le especificamos
            forCellReuseIdentifier: HouseTableViewCell.identifier)
        
        // 2. Configurar el data source
        dataSource = DataSource(tableView: tableView) {
            tableView, indexPath, house in
            
            // Obtenemos una celda reusable y la casteamos al tipo de celda que queremos representar
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HouseTableViewCell.identifier,
                for: indexPath
            ) as? HouseTableViewCell else {
                
                // Si no podemos desempaquetarla retornamos una celda en blanco
                return UITableViewCell()
            }
            cell.configure(with: house, isFavourite: false)
            return cell
        }
        
        // 3. Añadir el data source al table view
        tableView.dataSource = dataSource
        
        // 4. Crear un snapshot con los objetos a representar
        // TODO: - Investigar que es un snapshot
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(houses)
        
        // 5. Aplicar el snapshot al data source para añadir los objetos
        dataSource?.apply(snapshot)
    }
}


// MARK: - Table View Delegate
extension HouseListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    // Con este método se nos va a notificar que la celda se ha seleccionado
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        // Obtenemos el índice de la fila seleccionada por el usuario
        let house = houses[indexPath.row]
        
        let detailViewController = HouseDetailViewController(house: house)
        detailViewController.favouriteHouseDelegate = self
        
        // Navegar a la pantalla donde se va a mostrar el detalle de la fila seleccionada
        navigationController?.show(detailViewController, sender: self)
    }
}

extension HouseListViewController: FavouriteHouseDelegate {
    func didToggleFavourite(for house: House) {
        print("\(house)")
    }
    
    
}
