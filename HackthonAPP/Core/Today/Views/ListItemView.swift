//
//  ListItemView.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import SwiftUI

struct ListItemView: View {
    @EnvironmentObject private var vm:HomeViewModel
    let item:TaskModel
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? Color.theme.gray : Color.theme.orange)
                .accessibilityLabel(item.isCompleted ? Text("已完成\(item.title)") : Text("未完成\(item.title)")
                )
            Text(item.title)
                .accessibilityLabel(item.isCompleted ? Text("已完成\(item.title)") : Text("未完成\(item.title)")
                )
            Image(systemName: "flag.fill")
                .font(.title3)
                .foregroundColor(
                    
                    vm.priArray.first(where: { (p,_,c) in
                        return item.priority == p
                    })?.2 ?? Color.theme.gray

                )
                

            Spacer()
            
            if let time = item.remindeTime{
//                Text("提醒时间\n \(time.readableString(format: "dd MMM hh.mm"))")

            Text("\(time.chString())")
                .font(.headline)
                .foregroundColor(.theme.blue)
                
            }
            
            
        }
        .font(.title3)
        .padding(.vertical,24)
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ListItemView(item: TaskModel(title: "Hello", isCompleted: false, creteTime: Date(), remindeTime: Date(), priority: .P0, isRepeated: false))
            
            ListItemView(item: TaskModel(title: "Hello", isCompleted: false, creteTime: Date(), remindeTime: nil, priority: .P2, isRepeated: false))
          
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(HomeViewModel())
       
    }
}
