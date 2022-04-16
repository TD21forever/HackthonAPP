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
                .foregroundColor(item.isCompleted ? Color.theme.gray : Color.theme.orange)
            Text(item.title)

            Spacer()
            
            if let time = item.remindeTime{
//                Text("提醒时间\n \(time.readableString(format: "dd MMM hh.mm"))")

            Text("\(time.chString())")
                .font(.headline)
                .foregroundColor(.theme.blue)
                
            }
            
            
        }
        .font(.title)
        .padding(.vertical,24)
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ListItemView(item: TaskModel(title: "Hello", isCompleted: false, creteTime: Date(), remindeTime: Date(), priority: .P0))
            
            ListItemView(item: TaskModel(title: "Hello", isCompleted: false, creteTime: Date(), remindeTime: nil, priority: .P2))
          
        }
        .previewLayout(.sizeThatFits)
       
    }
}
