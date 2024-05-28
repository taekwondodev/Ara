//
//  Category.swift
//  Deaf
//
//  Created by Davide Galdiero on 28/05/24.
//

import Foundation
import SwiftData

@Model
class Category{
    var name: String
    
    init(name: String) {
        self.name = name
    }
}


//TODO: una query per un array di category salvate quando devo selezionare una category da inserire
//TODO: un bottone per creare una category che ti manda una textfield, dove creo una category e la inserisco
