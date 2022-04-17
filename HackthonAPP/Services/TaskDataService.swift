//
//  TaskDataService.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/17.
//

import Foundation
import CoreData

class TaskDataService{
    
    var container:NSPersistentContainer
    
    
    @Published var savedData:[TaskEntity] = []

    
    init(){
        container = NSPersistentContainer(name: "TaskData")
        container.loadPersistentStores { (description,error) in
            if let error = error {
                print("Error loading persistent data\(error)")
            }
        }
        fetchData()
    }
    
    func deleteTaskData(task:TaskModel){
        if let taskEntity = savedData.first(where: {$0.id == task.id}){
            print("Delete")
            delete(entity: taskEntity)
        }
    }
    
    func updateTaskData(task:TaskModel){
        if let taskEntity = savedData.first(where: {$0.id == task.id}){
            if task.isCompleted {
                print("Delete")
                delete(entity: taskEntity)
            }
            else{
                print("Update")
                update(entity: taskEntity, task: task)
            }
        }
        else{
            print("Add")
            print(task)
            add(task: task)
        }
    }
    
    private func fetchData(){
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        do {
            savedData = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching Data \(error)")
        }
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error Saving To Core Data\(error)")
        }
    }
    
    private func update(entity:TaskEntity,task:TaskModel){
        delete(entity: entity)
        add(task: task)
        applyChange()
    }
    
    
    private func add(task:TaskModel){
        let newItem = TaskEntity(context: container.viewContext)
        newItem.id = task.id
        newItem.createTime = task.createTime
        newItem.isCompleted = task.isCompleted
        newItem.isRepeated = task.isRepeated
        newItem.priority = task.priority.rawValue
        newItem.title = task.title
        if task.remindeTime == nil {
            newItem.setNilValueForKey("remindeTime")
        }
        else{
            newItem.remindeTime = task.remindeTime
        }
        applyChange()
    }
    
    private func delete(entity:TaskEntity){
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func applyChange(){
        save()
        fetchData()
    }
    
}
