//
//  ViewController.swift
//  iTask
//
//  Created by Aluno Mack on 18/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var taskArray = [Task]()
    var currentTaskArray = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTasks()
    }
    
    private func setUpTasks(){
        taskArray.append(Task(titulo: "Comprar alimento", dataEntrega: "10/01/2020", prioridade: "Alta", icon: "pessoal", categoria: .pessoal))
        taskArray.append(Task(titulo: "Sair com o dog", dataEntrega: "10/01/2020", prioridade: "Baixa", icon: "pessoal", categoria: .pessoal))
        taskArray.append(Task(titulo: "Projeto importante", dataEntrega: "10/01/2020", prioridade: "Alta", icon: "profissional", categoria: .profissional))
        taskArray.append(Task(titulo: "Estudar pra prova", dataEntrega: "10/01/2020", prioridade: "Baixa", icon: "academico", categoria: .academico))
        
        currentTaskArray = taskArray
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    // TABLE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTaskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        
        cell.tituloLbl.text = currentTaskArray[indexPath.row].titulo
        cell.dataLbl.text = currentTaskArray[indexPath.row].dataEntrega
        cell.prioridadeLbl.text = currentTaskArray[indexPath.row].prioridade
        cell.iconView.image = UIImage(named: currentTaskArray[indexPath.row].icon)
        
        return cell
    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentTaskArray = taskArray.filter({ task -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return task.titulo.lowercased().contains(searchText.lowercased())
            case 1:
                if searchText.isEmpty { return true }
                return task.titulo.lowercased().contains(searchText.lowercased())

            default:
                return false
            }
        })
        table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentTaskArray = taskArray
        case 1:
            currentTaskArray = taskArray
        default:
            break
        }
        table.reloadData()
    }

}

class Task {
    let titulo: String
    let dataEntrega: String
    let prioridade: String
    let categoria: TaskType
    let icon: String
    
    init(titulo: String, dataEntrega: String, prioridade: String, icon: String, categoria: TaskType) {
        self.titulo = titulo
        self.dataEntrega = dataEntrega
        self.prioridade = prioridade
        self.categoria = categoria
        self.icon = icon
    }
}

enum TaskType: String {
    case academico = "Acadêmico"
    case profissional = "Profissional"
    case pessoal = "Pessoal"
}
