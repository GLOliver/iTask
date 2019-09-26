//
//  Tarefa+CoreDataProperties.swift
//  iTask
//
//  Created by Aluno Mack on 23/09/2019.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//
//

import Foundation
import CoreData


extension Tarefa {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tarefa> {
        return NSFetchRequest<Tarefa>(entityName: "Tarefa")
    }

    @NSManaged public var categoria: String?
    @NSManaged public var dataEntrega: NSDate?
    @NSManaged public var icon: String?
    @NSManaged public var prioridade: String?
    @NSManaged public var titulo: String?
    @NSManaged public var descricao: String?

}
