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
    @EnvironmentObject private var vm:HomeViewModel
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        
        VStack(spacing:35){
            HStack(spacing:20){
                
                VStack{
                    Text(getYearAndMonth()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(getYearAndMonth()[1])
                        .font(.title.bold())
                    
                }
                
                Spacer(minLength: 0)
                
                HStack{
                    Button {
                        withAnimation {
                            currentMonthIdx -= 1
                        
                        }
                       
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                    
                    Button {
                        withAnimation {
                            currentMonthIdx += 1
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    
                }
                .foregroundColor(Color.theme.gray)
              
            }
            .padding()
            
            let days: [String] = ["周一","周二","周三","周四","周五","周六","周日"]
            
            HStack(spacing: 0){
                ForEach(days,id: \.self){ day in
                    
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 45){
                ForEach(getSingleDayArray()){ value in
                    CardView(value: value)
                }
            }
            
            
            Spacer()
            
        }
        .onChange(of: currentMonthIdx) { newValue in
            print(currentMonthIdx)
            print(getCurMonth())
            print("====")
            self.currentDate = getCurMonth()

        }
    }
}

extension CustomCalendar{
    
    
    @ViewBuilder
    func CardView(value: DateModel)->some View{
        
        VStack{
            
            if value.day != -1{
                
                if let task = vm.tasks.first(where: {$0.createTime.isSameDay(date: value.date)})
                {
                    
                    
                    Text("\(value.day)")
                        .font(.title3)
                        .opacity(value.day == -1 ? 0 : 1)
                    
                    Spacer()
                    
                    Circle()
                        .fill(value.date.isSameDay(date: currentDate) ? Color.theme.orange : Color.theme.blue )
                    
                        .frame(width: 8, height: 8)
                }else{
                    
                    Text("\(value.day)")
                        .font(.title3)
                        .opacity(value.day == -1 ? 0 : 1)
                    
                    Spacer()
                }
                    
                
            }
            
        }
        .padding(.vertical,8)
        .frame(width: 60, height: 60, alignment: .top)
  
        
        
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
