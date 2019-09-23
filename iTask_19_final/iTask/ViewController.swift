//
//  ViewController.swift
//  iTask
//
//  Created by Aluno Mack on 18/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//
import UserNotifications
import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var taskArray = [Task]()
    var currentTaskArray = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerLocal()
        setUpTasks()
        sortTasks()
        setUpSearchBar()
        alterLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sortTasks()
        table.reloadData()
    }
    
    func sortTasks(){
        taskArray.sort { (a, b) -> Bool in
            a.dataEntrega < b.dataEntrega
        }
        currentTaskArray.sort { (a, b) -> Bool in
            a.dataEntrega < b.dataEntrega
        }
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
              print("ay!")
            } else {
              print("D'oh!")
            }
        }
    }
    
    func scheduleLocal(_ newtask: Task){
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = newtask.titulo
        content.body = "Data de entrega: HOJE!!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["cuctomData": "fizzbuzz"]
        content.sound = .default
        
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        
  //      let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
        
    }
    
    private func setUpTasks(){
         let dateRng = Int.random(in: -100...100)
        taskArray.append(Task(titulo: "Comprar alimento", dataEntrega: Date().addingTimeInterval(TimeInterval(dateRng * 86400)), prioridade: "Alta", icon: "pessoal", categoria: "pessoal"))
        taskArray.append(Task(titulo: "Sair com o dog", dataEntrega: Date().addingTimeInterval(TimeInterval(dateRng * 86400)), prioridade: "Baixa", icon: "pessoal", categoria: "pessoal"))
        taskArray.append(Task(titulo: "Projeto importante", dataEntrega: Date().addingTimeInterval(TimeInterval(dateRng * 86400)), prioridade: "Alta", icon: "profissional", categoria: "pessoal"))
        taskArray.append(Task(titulo: "Estudar pra prova", dataEntrega: Date().addingTimeInterval(TimeInterval(dateRng * 86400)), prioridade: "Baixa", icon: "academico", categoria: "pessoal"))
        taskArray.append(Task(titulo: "Comprar alimento", dataEntrega: Date().addingTimeInterval(TimeInterval(dateRng * 86400)), prioridade: "Alta", icon: "pessoal", categoria: "pessoal"))
        taskArray.append(Task(titulo: "Sair com o dog", dataEntrega: Date().addingTimeInterval(TimeInterval(dateRng * 86400)), prioridade: "Baixa", icon: "pessoal", categoria: "pessoal"))
        taskArray.append(Task(titulo: "Projeto importante", dataEntrega: Date().addingTimeInterval(TimeInterval(dateRng * 86400)), prioridade: "Alta", icon: "profissional", categoria: "pessoal"))
        taskArray.append(Task(titulo: "Estudar pra prova", dataEntrega: Date().addingTimeInterval(TimeInterval(dateRng * 86400)), prioridade: "Baixa", icon: "academico", categoria: "pessoal"))
        currentTaskArray = taskArray
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
        
        let formattedDate = DateFormatter.localizedString(from: currentTaskArray[indexPath.row].dataEntrega, dateStyle: .medium, timeStyle: .none)
        
        cell.tituloLbl.text = currentTaskArray[indexPath.row].titulo
        cell.dataLbl.text = formattedDate
        cell.prioridadeLbl.text = currentTaskArray[indexPath.row].prioridade
        cell.iconView.image = UIImage(named: currentTaskArray[indexPath.row].icon)
        
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
            task.titulo.lowercased().contains(searchText.lowercased())
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            if let dest = segue.destination as? AddTaskViewController {
                dest.prevController = self
                
            }
        }
        
    }

    
    
}


