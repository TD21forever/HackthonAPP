//
//  CustomCalendar.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import SwiftUI

struct CustomCalendar: View {
    @Binding var currentDate: Date
    @State var currentMonthIdx:Int = 0
    @State var today:Date = Date()
    @EnvironmentObject private var vm:HomeViewModel
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let days: [String] = ["周一","周二","周三","周四","周五","周六","周日"]

    var body: some View {
        
        VStack(spacing:35){
            
            header
            .padding()
            
            week
            
            dates

            Spacer()
            
        }
        .onChange(of: currentMonthIdx) { newValue in
            self.currentDate = getCurMonth()

        }
    }
}

extension CustomCalendar{
    
    
    
    @ViewBuilder
    func CardView(value: DateModel)->some View{
        
        VStack{
            
            if value.day != -1{
                
                let tasks = vm.tasks.filter { taskData in
                    return taskData.createTime.isSameDay(date: value.date)
                }
                
                let taskP0 = tasks.first(where: {$0.priority == .P0})
                let taskP1 = tasks.first(where: {$0.priority == .P1})
                let taskP2 = tasks.first(where: {$0.priority == .P2})
                let taskP3 = tasks.first(where: {$0.priority == .P3})
                
                let taskP = [taskP0,taskP1,taskP2,taskP3]
                
                Text("\(value.day)")
                    .font(.title3)
                    .opacity(value.day == -1 ? 0 : 1)
                    .accessibilityLabel(Text("\(getYearAndMonth()[1])\(value.day)日"))
                Spacer()
                
                VStack{
                    
                    ForEach(0..<taskP.count) { idx in
                        let task = taskP[idx]
                        if task != nil {
                            Circle()
                                .fill(
                                    vm.priArray.first(where: { (p,_,_) in
                                        return task?.priority == p
                                    })?.2 ?? Color.theme.gray
                                )
                                .frame(width: 8, height: 8)
                        }
                    }
                }
            }
            
        }
        .padding(.vertical,8)
        .frame(width: 60, height: 60, alignment: .top)
  
        
        
    }
    
    private var header:some View {
        HStack(spacing:20){
            
            VStack{
                Text(getYearAndMonth()[0])
                    .font(.caption)
                    .fontWeight(.semibold)
                
                Text(getYearAndMonth()[1])
                    .font(.title.bold())
                    .accessibilityLabel(Text("\(getYearAndMonth()[0])年\(getYearAndMonth()[1])"))
                
            }
            HStack(spacing:0){
                
                ForEach(0..<vm.priArray.count) { idx in
                    Label(vm.priArray[idx].0.rawValue, systemImage: vm.priArray[idx].1)
                        .foregroundColor(vm.priArray[idx].2)
                }
                
            }
          
            
            HStack{
                Button {
                    withAnimation {
                        currentMonthIdx -= 1
                    
                    }
                   
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                }
                .accessibilityLabel(Text("返回一个月"))
                
                
                Button {
                    withAnimation {
                        currentMonthIdx += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                }
                .accessibilityLabel(Text("前进一个月"))
                
            }
            .foregroundColor(Color.theme.gray)
          
        }
    }
    
    
    private var week:some View {
        
        HStack(spacing: 0){
            ForEach(days,id: \.self){ day in
                
                Text(day)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
        }
        
    }
    
    private var dates:some View{
        
        LazyVGrid(columns: columns, spacing: 45){
            ForEach(getSingleDayArray()){ value in
                CardView(value: value)
            }
        }
    }
    
    private func getYearAndMonth()->[String]{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_hans_CN")
        formatter.timeZone = TimeZone(identifier: "CCD")
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    private func getCurMonth()->Date{
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: currentMonthIdx, to: Date())
        else { return Date() }
        return currentMonth
        
    }
    
    private func getSingleDayArray()->[DateModel]{
        
        let calendar = Calendar.current
        
        let currentMonth = getCurMonth()
        
        var days =  currentMonth.getOneMonthDates().compactMap { date->DateModel in
            
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            
            return DateModel(day: day, month: month, year: year, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
    
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateModel(day: -1, month: 0, year: 0, date: Date()), at: 0)
        }
        return days
        
    }
    
}
struct CustomCalendar_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalendar(currentDate: .constant(Date()))
            .environmentObject(HomeViewModel())
    }
}
