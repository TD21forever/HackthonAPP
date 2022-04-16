//
//  ListItemView.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import SwiftUI

struct ListItemView: View {
    let item:TaskModel
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? Color.theme.green : Color.theme.red)
            Text(item.title)
            if let time = item.remindeTime{
                Text("提醒时间\(time.description)")
            }
            
            Spacer()
        }
        .font(.title2)
        .padding(.vertical,10)
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ListItemView(item: TaskModel(title: "Hello", isCompleted: false, creteTime: Date(), remindeTime: Date()))
            
            ListItemView(item: TaskModel(title: "Hello", isCompleted: false, creteTime: Date(), remindeTime: nil))
          
        }
        .previewLayout(.sizeThatFits)
       
    }
}
