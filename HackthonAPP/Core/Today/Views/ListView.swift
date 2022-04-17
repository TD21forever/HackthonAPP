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
    @State var count:Int = 0
    var body: some View {
        VStack{
            
            listHeader
            .foregroundColor(Color.theme.accent)
            .font(.title2)
            .padding()
            
            ZStack{
                
                listContent
                    .listStyle(PlainListStyle())
                
                
                if getCount() == 0{
                    Text("还没有任务,点击右上角的➕进行添加")
                        .font(.title)
                        .foregroundColor(.theme.gray.opacity(0.5))
                        .padding(30)
                }
            }
           
        }
        .sheet(isPresented: $isShowAddItem) {
            AddItemView(date: $date, isPresented: $isShowAddItem)
        }
        
     
    }
    
    func getCount()->Int{
        return vm.tasks.filter({$0.createTime.isSameDay(date: date)}).count
    }
}

extension ListView{
    private var listHeader:some View{
        HStack{
            
            HStack{
                Text("任务列表")
                    .accessibilityLabel(Text("这天是\( date.readableString(format: "YYYY dd MMM")),这天共有\( getCount() )个任务"))
                
                
                Text("\(getCount())")
                    .font(.callout)
                    .foregroundColor(Color.theme.gray)
   
            }
            
            Spacer()
            
            Button {
                isShowAddItem.toggle()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 44))
                    .accessibilityLabel(Text("添加任务"))
            }

            
        }
    }
    
    private var listContent: some View{
        VStack{
            
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
                .onDelete(perform: { idnexSet in
                    vm.deleteItem(indexSet: idnexSet)
                })
                .onMove(perform: vm.moveItem)
                
            }
        }

   
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(date: .constant(Date()))
            .environmentObject(HomeViewModel())
    }
}
