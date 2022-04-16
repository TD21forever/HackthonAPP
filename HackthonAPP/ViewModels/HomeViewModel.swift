//
//  HomeVIewModel.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import Foundation

class HomeViewModel:ObservableObject{
    
    @Published var tasks:[TaskModel] = [
    
        TaskModel(title: "吃饭", isCompleted: false, creteTime: Date(), remindeTime: nil),
        TaskModel(title: "睡觉", isCompleted: false, creteTime: Date(), remindeTime: nil),
        TaskModel(title: "玩游戏", isCompleted: false, creteTime: Date(), remindeTime: nil),
        TaskModel(title: "打豆豆", isCompleted: false, creteTime: Date(), remindeTime: nil)
    
    ]
    
    
    func deleteItem(indexSet:IndexSet){
        tasks.remove(atOffsets: indexSet)
    }
    
    func moveItem(from:IndexSet,to:Int){
        tasks.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title:String, createTime:Date, remindeTime:Date?){
        let newItem = TaskModel(title: title, isCompleted: false, creteTime: createTime, remindeTime: remindeTime)
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
