//
//  TaskDetailViewController.swift
//  iTask
//
//  Created by Aluno Mack on 20/09/2019.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskIcon: UIImageView!
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var prioTask: UILabel!
    @IBOutlet weak var descricaoTask: UILabel!
    
    var tituloTask: String?
    var imgTask:UIImage?
    var dataTask:String?
    var prioridadeTask:String?
    var descriTask:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTitle.text = tituloTask
        taskIcon.image = imgTask
        taskDate.text = dataTask
        prioTask.text = prioridadeTask
        descricaoTask.text = descriTask
        


        // Do any additional setup after loading the view.
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
