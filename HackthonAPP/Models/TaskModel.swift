//
//  TaskModel.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import Foundation

struct TaskModel:Identifiable,Codable {
    
    var id:String = UUID().uuidString
    var title:String
    var isCompleted:Bool
    var createTime:Date = Date()
    var remindeTime:Date?
    var priority:Priority
    
    init(id:String=UUID().uuidString, title:String, isCompleted:Bool, creteTime:Date, remindeTime:Date?, priority:Priority){
        
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createTime = creteTime
        self.remindeTime = remindeTime
        self.priority = priority
    }
    
    func updateCompletion()->TaskModel{
        return TaskModel(title: title, isCompleted: !isCompleted, creteTime: createTime, remindeTime: remindeTime, priority: priority)
    }

}

enum Priority: String, Codable {
    
    case P0, P1, P2, P3
}
