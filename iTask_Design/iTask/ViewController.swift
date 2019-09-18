//
//  ViewController.swift
//  iTask
//
//  Created by Aluno Mack on 17/09/2019.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tasks = ["task1", "task2", "task3"]

    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //image.layer.borderWidth = 1
        //image.layer.masksToBounds = false
        //image.layer.borderColor = UIColor.black.cgColor
        //image.layer.cornerRadius = image.frame.height/2
        //image.clipsToBounds = true
    
        // Image needs to be added to project.
        
   // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell"/*Identifier*/, for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        
        cell.imageView?.image = UIImage(named:"29302.png")
        
        return cell
    }

}

