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
    var createTime:Date
    var remindeTime:Date?
    var priority:Priority
    var isRepeated:Bool
    
    init(id:String=UUID().uuidString, title:String, isCompleted:Bool, creteTime:Date, remindeTime:Date?, priority:Priority,isRepeated:Bool){
        
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createTime = creteTime
        self.remindeTime = remindeTime
        self.priority = priority
        self.isRepeated = isRepeated
    }
    
    func updateCompletion()->TaskModel{
    
        return TaskModel(id:id, title: title, isCompleted: !isCompleted, creteTime: createTime, remindeTime: remindeTime, priority: priority, isRepeated: isRepeated)
    }

}

enum Priority: String, Codable {
    
    case P0, P1, P2, P3
}
