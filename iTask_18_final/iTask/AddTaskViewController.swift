//
//  AddTaskViewController.swift
//  iTask
//
//  Created by Aluno Mack on 17/09/2019.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var datePickerIndexPath: IndexPath?
    var datePickerVisible: Bool { return datePickerIndexPath != nil }

    @IBOutlet weak var inputTextFieldDate: UITextField!
    
    private var datePicker: UIDatePicker?
    //@IBOutlet weak var roundedButton: UIButton!
    
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

}
