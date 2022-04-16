//
//  HomeVIewModel.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import Foundation
import SwiftUI

class HomeViewModel:ObservableObject{
    
    @Published var tasks:[TaskModel] = [
    
        TaskModel(title: "吃饭", isCompleted: false, creteTime: Date(), remindeTime: nil, priority: .P0),
        TaskModel(title: "睡觉", isCompleted: false, creteTime: Date(), remindeTime: nil, priority: .P1),
        TaskModel(title: "玩游戏", isCompleted: false, creteTime: Date(), remindeTime: nil, priority: .P2),
        TaskModel(title: "打豆豆", isCompleted: false, creteTime: Date(), remindeTime: nil, priority: .P3)
    
    ]
    
    let priArray = [
        
        (Priority.P0, "flag.fill", Color.theme.red),
        (Priority.P1, "flag.fill", Color.theme.orange),
        (Priority.P2, "flag.fill", Color.theme.blue),
        (Priority.P3, "flag.fill", Color.theme.gray),

    ]
    
    

    
    
    func deleteItem(indexSet:IndexSet){
        tasks.remove(atOffsets: indexSet)
    }
    
    func moveItem(from:IndexSet,to:Int){
        tasks.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title:String, createTime:Date, remindeTime:Date?, priority:Priority){
        let newItem = TaskModel(title: title, isCompleted: false, creteTime: createTime, remindeTime: remindeTime, priority: priority)
        tasks.append(newItem)
    }
    
    
    func updateItem(item:TaskModel){
        if let index = tasks.firstIndex(where: { curItem in
            item.id == curItem.id
        }) {
            tasks[index] = item.updateCompletion()
        }
    }
    
    
}
