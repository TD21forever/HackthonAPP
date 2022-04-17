//
//  HomeVIewModel.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import Foundation
import SwiftUI
import UIKit
import CoreData
import Combine

class HomeViewModel:ObservableObject {
    
    private let taskDataService = TaskDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
  
    init(){
        addSubscribers()
    }
    
    @Published var tasks:[TaskModel] = [

    
    ]
    
    func addSubscribers(){
        
        taskDataService.$savedData
            .map { tasksEntities->[TaskModel] in
                
                var taskModelList:[TaskModel] = []
                
                for entity in tasksEntities{
                    guard
                        let id = entity.id,
                        let title = entity.title,
                        let createTime = entity.createTime,
                        let priority = entity.priority
                            
                    else{
                        print(entity)
                        return []
                    }
                    
                    let remindeTime = entity.remindeTime == nil ? nil : entity.remindeTime
                        
                    let task = TaskModel(id: id, title: title, isCompleted: entity.isCompleted, creteTime: createTime , remindeTime: remindeTime, priority: Priority.init(rawValue: priority) ?? .P3 , isRepeated: entity.isRepeated)
                    
                    taskModelList.append(task)

                    
                }

                return taskModelList
            }
            .sink{ [weak self] data in
              
                self?.tasks = data
               
            }
            .store(in: &cancellables)

    }
    
    
    func updatePortfolio(task:TaskModel){
        taskDataService.updateTaskData(task: task)
    }


    
    let priArray = [
        
        (Priority.P0, "flag.fill", Color.theme.red),
        (Priority.P1, "flag.fill", Color.theme.orange),
        (Priority.P2, "flag.fill", Color.theme.blue),
        (Priority.P3, "flag.fill", Color.theme.gray),

    ]
    
    
    func deleteItem(indexSet:IndexSet){
        
        guard let index = indexSet.first else {return}
        let task = tasks[index]
        tasks.remove(atOffsets: indexSet)
        taskDataService.deleteTaskData(task: task)
        
    }
    
    func moveItem(from:IndexSet,to:Int){
        tasks.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title:String, createTime:Date, remindeTime:Date?, priority:Priority, isReapted:Bool)->TaskModel{
        let newItem = TaskModel(title: title, isCompleted: false, creteTime: createTime, remindeTime: remindeTime, priority: priority, isRepeated: isReapted)
        tasks.append(newItem)
        return newItem
    }
    
    
    func updateItem(item:TaskModel){
        // 点击task更新的逻辑
        if let index = tasks.firstIndex(where: { curItem in
            item.id == curItem.id
        }) {
            let completedTask = tasks[index].updateCompletion()
            // 完成了就删除
            tasks.remove(at: index)
            // 更新coredata
            updatePortfolio(task: completedTask)
            
            if completedTask.isRepeated && completedTask.remindeTime != nil {
                // 如果是重复则 创建一个新的task
                let current = Calendar.current
                guard
                    let newDate = current.date(byAdding: .day, value: 1, to: completedTask.createTime),
                    let completedTaskReminderTime = completedTask.remindeTime,
                    let newReminderTime = current.date(byAdding: .day, value: 1, to: completedTaskReminderTime)
                else {return}



                let newTask = TaskModel(title: completedTask.title, isCompleted: false, creteTime: newDate, remindeTime: newReminderTime, priority: completedTask.priority, isRepeated: completedTask.isRepeated)

                tasks.append(newTask)
                updatePortfolio(task: newTask)

            }

        }
    }
    
    
}
