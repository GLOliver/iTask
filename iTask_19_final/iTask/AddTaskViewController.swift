//
//  AddTaskViewController.swift
//  iTask
//
//  Created by Aluno Mack on 17/09/2019.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit
import UserNotificationsUI

class AddTaskViewController: UIViewController {
    
    
    
    var datePickerIndexPath: IndexPath?
    var datePickerVisible: Bool { return datePickerIndexPath != nil }

    @IBOutlet weak var inputTextFieldDate: UITextField!
    
    @IBOutlet weak var tituloInput: UITextField!
    @IBOutlet weak var prioriInput: UITextField!
    @IBOutlet weak var catInput: UITextField!
    @IBOutlet weak var descricaoInput: UITextField!
    private var datePicker: UIDatePicker?
    //@IBOutlet weak var roundedButton: UIButton!
    
    weak var prevController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        inputTextFieldDate.inputView = datePicker
        
        //roundedButton.layer.cornerRadius = 8
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        inputTextFieldDate.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
    }
    
    
    
    @IBAction func save(_ sender: Any) {
        guard let newName = tituloInput.text, let newCategoria = catInput.text, let newPrio = prioriInput.text, let newDescrition = descricaoInput.text, let newDate = datePicker?.date else { return }
        var newicon = "pessoal"
        if newCategoria == "academico" {
            newicon = "academico"
        } else if newCategoria == "pessoal" {
            newicon = "pessoal"
        } else if newCategoria == "profissional" {
            newicon = "profissional"
        } else {
            newicon = "pessoal"
        }
        
        let newTask = Task(titulo: newName, dataEntrega: newDate, prioridade: newPrio, icon: newicon, categoria: newCategoria)
        
        if let prevController = prevController{
            prevController.currentTaskArray.append(newTask)
            prevController.taskArray.append(newTask)
            prevController.scheduleLocal(newTask)
        }
        
        prevController?.table.reloadData()
        navigationController?.popViewController(animated: true)
        
        
    }
    
    

}
