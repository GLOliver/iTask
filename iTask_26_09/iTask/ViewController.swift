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
    private let searchController = UISearchController(searchResultsController: nil)
    
   
    var taskArray = [Tarefa]()
    var currentTaskArray = [Tarefa]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sortTasks()
        setUpSearchBar()
        alterLayout()
        
        table.delegate = self
        table.dataSource = self
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
       let tasks = CoreDataManager.sharedInstance.getTasks()
        taskArray = tasks
        currentTaskArray = tasks
        sortTasks()
        table.reloadData()
        //sortPriority()
        //table.reloadData()
    }
    
    func sortTasks(){
        taskArray.sort { (a, b) -> Bool in
            (a.dataEntrega! as Date) < (b.dataEntrega! as Date)
        }
        currentTaskArray.sort { (a, b) -> Bool in
            (a.dataEntrega! as Date) < (b.dataEntrega! as Date)
        }
    }
    
    func sortPriority(){
        taskArray.sort { (a,b) -> Bool in
            a.prioridade == "Alta"
        }
        
        currentTaskArray.sort { (a,b) -> Bool in
            a.prioridade == "Alta"
        }
    }
    

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let removedItem = taskArray[indexPath.row]
            CoreDataManager.sharedInstance.deleteObject(object: removedItem)

            if let indexToRemove = taskArray.firstIndex(of: removedItem){
                taskArray.remove(at: indexToRemove)
            }
            
            currentTaskArray = taskArray
            sortTasks()
            self.table.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func alterLayout() {
        //table.tableHeaderView = UIView()
        // search bar in section header
        table.estimatedSectionHeaderHeight = 50
        // search bar in navigation bar
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        //navigationItem.titleView = searchBar
        // you can show/hide this dependant on your layout
        searchBar.placeholder = "Pesquise uma tarefa pelo titulo"
    }
    
    // TABLE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTaskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        
        let formattedDate = DateFormatter.localizedString(from: currentTaskArray[indexPath.row].dataEntrega as! Date, dateStyle: .medium, timeStyle: .none)
        
        cell.tituloLbl.text = currentTaskArray[indexPath.row].titulo
        cell.dataLbl.text = formattedDate
        cell.prioridadeLbl.text = currentTaskArray[indexPath.row].prioridade
        cell.iconView.image = UIImage(named: currentTaskArray[indexPath.row].icon!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentTaskArray = taskArray
            table.reloadData()
            return
            
        }
        currentTaskArray = taskArray.filter({ task -> Bool in
            (task.titulo?.lowercased().contains(searchText.lowercased()))!
        })
        table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            sortTasks()
        case 1:
            sortPriority()
        default:
            break
        }
        table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            if let dest = segue.destination as? AddTaskViewController {
                dest.prevController = self
                
            }
        }
        
        if segue.identifier == "showTaskDetail" {
            if let indexPath = table.indexPathForSelectedRow {
                if let dest = segue.destination as? TaskDetailViewController {
                    print("proxima tela")
                    
                    //Titulo da tarefa
                    dest.tituloTask = taskArray[indexPath.row].titulo
                       
                    // Icone
                    dest.imgTask = UIImage(named: taskArray[indexPath.row].icon!)
                    
                    // Data
                    let dateformatter = DateFormatter()
                    dateformatter.dateFormat = "dd/MM/yyyy"
                    let dateNew = dateformatter.string(from: taskArray[indexPath.row].dataEntrega as! Date)
                    dest.dataTask = dateNew
                    
                    // Prioridade
                    dest.prioridadeTask = taskArray[indexPath.row].prioridade
                    
                    // Descricao
                    dest.descriTask = taskArray[indexPath.row].descricao
                    
                }
                
            }
        }
        
    }

    
    
}


