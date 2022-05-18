//
//  ViewController.swift
//  tableview
//
//  Created by Aluno02 on 14/05/22.
//  Copyright © 2022 Daniel Morais. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var jardimTableView: UITableView!
    
    struct Sunset {
        let title: String
        let imageName: String
    }
    
    var data: [Sunset] = []
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        jardimTableView.dataSource = self
        jardimTableView.delegate = self
        
        for sun in 1..<10 {
            data.append(Sunset(title: "Planta \(sun)", imageName: "\(sun).png"))
        }
    }
    
    // indice da tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //construcao
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sunset = data[indexPath.row]
        let cell = jardimTableView.dequeueReusableCell(withIdentifier: "plantaCell", for: indexPath) as! plantaTableViewCell
        cell.plantaLabel.text = sunset.title
        cell.plantaImageView.image = UIImage(named: sunset.imageName)
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // cria menú de deslize para apagar a lista
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {action, indexPath in
            self.data.remove(at: indexPath.row)
            self.jardimTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction]
    }
}

