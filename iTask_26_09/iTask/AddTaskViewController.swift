//
//  AddTaskViewController.swift
//  iTask
//
//  Created by Aluno Mack on 17/09/2019.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let priorityArray:Array<String> = ["Alta", "Baixa"]
    let categoriesArray:Array<String> = ["academico", "pessoal", "profissional"]
    
    var dataSource: Array<String> = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return priorityArray.count
        if pickerView == categoriesPicker {
            return categoriesArray.count
        } else if pickerView == prioritiesPicker {
            return priorityArray.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return priorityArray[row]
        if pickerView == categoriesPicker {
            return categoriesArray[row]
        } else if pickerView == prioritiesPicker {
            return priorityArray[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoriesPicker {
            catInput.text = categoriesArray[row]
        } else if pickerView == prioritiesPicker {
            prioriInput.text = priorityArray[row]
        }
    }

    @IBOutlet weak var inputTextFieldDate: UITextField!
    
    @IBOutlet weak var tituloInput: UITextField!
    @IBOutlet weak var prioriInput: UITextField!
    @IBOutlet weak var catInput: UITextField!
    @IBOutlet weak var descricaoInput: UITextField!
    private var datePicker: UIDatePicker?
    
    let prioritiesPicker:UIPickerView = UIPickerView()
    let categoriesPicker:UIPickerView = UIPickerView()
    
    //@IBOutlet weak var roundedButton: UIButton!
    
    weak var prevController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        prioriInput.inputView = prioritiesPicker
        prioritiesPicker.dataSource = self
        prioritiesPicker.delegate = self
        
        catInput.inputView = categoriesPicker
        categoriesPicker.dataSource = self
        categoriesPicker.delegate = self
        
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
        
        CoreDataManager.sharedInstance.insertTask(titulo: newName, dataEntrega: newDate, prioridade: newPrio, categoria: newCategoria, icon: newicon, descricao: newDescrition)
    
        //prevController?.table.reloadData()
        navigationController?.popViewController(animated: true)
    
    }
    

}

    
    

