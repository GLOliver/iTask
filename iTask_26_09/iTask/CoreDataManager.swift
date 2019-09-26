//
//  CoreDataManager.swift
//  iTask
//
//  Created by Aluno Mack on 23/09/2019.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getTasks() -> [Tarefa] {
        do{
            let tasks:[Tarefa] = try persistentContainer.viewContext.fetch(Tarefa.fetchRequest())
            return tasks
        } catch {
            print("CoreData error")
        }
        return []
    }
    
    func insertTask(titulo: String, dataEntrega: Date, prioridade: String, categoria: String, icon:String, descricao: String) {
        guard let newTask = NSEntityDescription.insertNewObject(forEntityName: "Tarefa", into: persistentContainer.viewContext) as? Tarefa else { return }
        newTask.titulo = titulo
        newTask.dataEntrega = dataEntrega as NSDate
        newTask.prioridade = prioridade
        newTask.categoria = categoria
        newTask.icon = icon
        newTask.descricao = descricao
        saveContext()
    }
    
    func deleteObject(object:NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        saveContext()
    }
    
}
