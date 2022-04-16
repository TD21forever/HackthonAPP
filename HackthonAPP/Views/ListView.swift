//
//  ListView.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject private var vm:HomeViewModel
    @State var isShowAddItem:Bool = false
    @Binding var date:Date
    
    var body: some View {
        VStack{
            
            HStack{
                Text("任务列表")
                Spacer()
                Button {
                    isShowAddItem.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }

                
            }
            .foregroundColor(Color.theme.accent)
            .font(.title)
            .padding()
            
            List{
                ForEach(vm.tasks){ item in
                    if item.createTime.isSameDay(date: date){
                        
                        ListItemView(item: item)
                            .onTapGesture {
                                withAnimation(.none){
                                    vm.updateItem(item: item)
                                }
                            }
                    }
                  
                }
                .onDelete(perform: vm.deleteItem)
                .onMove(perform: vm.moveItem)
                
            }
            .listStyle(PlainListStyle())
        }
        .sheet(isPresented: $isShowAddItem) {
            AddItemView(date: $date, isPresented: $isShowAddItem)
        }
        
     
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(date: .constant(Date()))
            .environmentObject(HomeViewModel())
    }
}
