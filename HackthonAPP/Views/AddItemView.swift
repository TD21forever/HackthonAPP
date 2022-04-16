//
//  AddItemView.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import SwiftUI

struct AddItemView: View {
    

    @EnvironmentObject var vm:HomeViewModel
    
    // for create time
    @Binding var date:Date
    @Binding var isPresented:Bool
    
    @State var textFieldText:String = ""
    @State var showAlert:Bool = false
    @State var alertTitle:String = ""
    @State var showAddReminder:Bool = false
    @State var reminderDate:Date = Date()
    
    enum ReminderOption {
        case everyDay, specificDay, none
    }
    
    @State var reminderOption: ReminderOption = .none

    var body: some View {
        NavigationView{
            
            VStack{
                
                // 输入框
                HStack{
                    TextField("请输入你的任务", text: $textFieldText)
                        
                        .padding(.horizontal)
                        .frame(height: 65)
                        .background(Color.theme.black.opacity(0.3))
                        .cornerRadius(10)

                }
                .padding(.vertical)
                
                
                // 提醒按钮
                
                HStack(){
                    // 在指定日期提醒我
                    Button {
                        withAnimation(.linear(duration: 0.05)) {
                            reminderOption = .specificDay
                        }
                        
                    } label: {
                        
                        HStack {
                            
                               Image(systemName: "calendar.badge.clock")
                                   .font(.title2)
                               Text("指定日期")
                                   .fontWeight(.semibold)
                                   .font(.title2)
                           }
                           .padding()
                           .padding(.trailing, 12)
                           .foregroundColor(.white)
                           .background(Color.theme.black)
                           .cornerRadius(10)
                   
                            
                    }
                    
                    Spacer()
                    
                    // 每日提醒我
                    
                    Button {
                        withAnimation(.linear(duration: 0.02)) {
                            reminderOption = .everyDay
                        }
                        
                    } label: {
                        
                        HStack {
                               Image(systemName: "clock.circle.fill")
                                   .font(.title2)
                               Text("每日提醒")
                                   .fontWeight(.semibold)
                                   .font(.title2)
                           }
                           .padding()
                           .padding(.leading, 12)
                           .foregroundColor(.white)
                           .background(Color.theme.black)
                           .cornerRadius(10)
                
                    }
                }
                
             
                switch reminderOption {
                    
                    case .everyDay:
                        
                        HStack{
                            Text("每日")
                            DatePicker("", selection: $reminderDate, displayedComponents: .hourAndMinute)
                                .padding(.vertical)
                            Text("提醒我")
                        }
                        .font(.title)
                    case .specificDay:
                        HStack{
                            Text("在")
                            DatePicker("", selection: $reminderDate)
                                .padding(.vertical)
                            Text("提醒我")
                        }
                        .font(.title)
                    case .none:
                    EmptyView()
                }
                

                
                Button {
                    saveButtonPressed(date)
                } label: {
                    Text("Save")
                }
                .foregroundColor(.white)
                .font(.title)
                .frame(height:65)
                .frame(maxWidth:.infinity)
                .background(Color.theme.black)
                .cornerRadius(10)

                Spacer()
            }
            .padding()
            .navigationTitle("新增任务😀")
            .navigationBarItems(trailing: Button(action: {
                isPresented = false
            }, label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .foregroundColor(.theme.black)
            }))
            .onDisappear{
                NotificationManager.instance.reloadLocalNotifications()
            }
        }
     
        
        
    }

        
}

extension AddItemView{
    
    func saveButtonPressed(_ date:Date){
        if checkIsTitleAppropriate(){
            
            switch reminderOption{
                
            case .specificDay:
                    let dateComponets = Calendar.current.dateComponents([.day, .hour, .minute], from: reminderDate)
                    
                    guard
                        let hour = dateComponets.hour,
                        let minute = dateComponets.minute,
                        let day = dateComponets.day
                            
                    else{
                        print("ERROR RETURN")
                        return
                    }
                
                NotificationManager.instance.createLocalNotificationForSpecificDay(title: textFieldText, day: day, hour: hour, minute: minute) { error in
                    
                    if error == nil {
                        
                        DispatchQueue.main.async {
                            showAddReminder = false
                        }
                        
                    }
                }
            case .everyDay:
                let dateComponets = Calendar.current.dateComponents([.hour, .minute], from: reminderDate)
                
                guard
                    let hour = dateComponets.hour,
                    let minute = dateComponets.minute
                        
                else{
                    print("ERROR RETURN EVERYDAY")
                    return
                }
            
                NotificationManager.instance.createLocalNotification(title: textFieldText, hour: hour, minute: minute, repeate: true, completion: { error in
                    if error == nil {
                        isPresented = false
                    }
                    
                })
            case.none:
                break
            }
                        
            vm.addItem(title: textFieldText, createTime: date, remindeTime: reminderOption != .none ? reminderDate : nil)
        }
    }
    
    func checkIsTitleAppropriate()->Bool{
        if textFieldText.count < 3{
            alertTitle = "Something wrong here"
            showAlert.toggle()
            return false
        }
        return true
    }
        
    func getAlert()->Alert{
        return Alert(title:Text(alertTitle))
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(date: .constant(Date()),isPresented: .constant(false))
    }
}
