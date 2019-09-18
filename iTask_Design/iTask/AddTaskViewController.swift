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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
