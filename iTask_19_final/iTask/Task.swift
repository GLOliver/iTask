//
//  Task.swift
//  iTask
//
//  Created by Aluno Mack on 19/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import Foundation

class Task {
    let titulo: String
    let dataEntrega: Date
    let prioridade: String
    let categoria: String
    let icon: String
    
    init(titulo: String, dataEntrega: Date, prioridade: String, icon: String, categoria: String) {
        self.titulo = titulo
        self.dataEntrega = dataEntrega
        self.prioridade = prioridade
        self.categoria = categoria
        self.icon = icon
    }
}

enum TaskType: String {
    case academico = "Acadêmico"
    case profissional = "Profissional"
    case pessoal = "Pessoal"
}

