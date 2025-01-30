//
//  DataManager.swift
//  Art App
//
//  Created by user on 27.01.2025.
//

import UIKit

protocol IDataManager {
    func addItems(_ items: [Artist])
    func getData() -> [Artist]
    func getWorks() -> [Work]
}


final class DataManager: IDataManager {
   
    private var artModel: [Artist] = []
    private var worksModel: [Work] = []
    
    func addItems(_ items: [Artist]) {
        self.artModel.append(contentsOf: items)
    }
    
    func getWorks() -> [Work] {
        worksModel
    }
    
    func getData() -> [Artist] {
        artModel
    }
    
   
}
