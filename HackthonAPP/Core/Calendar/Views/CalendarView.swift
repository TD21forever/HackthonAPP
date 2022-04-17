//
//  CalendarView.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import SwiftUI

struct CalendarView: View {
    @State var calendar:CalendarModel = CalendarModel(date: Date(), day: "", week: "", year: "", month: "")
    
    @Binding var date:Date
    
    let width = UIScreen.main.bounds.width
    var body: some View {
        ZStack{
            VStack{
          
                monthView
        
                dayAndWeekView
   
                Divider()
                
                yearView
           
            }
            .font(.title)
            
            dayAndWeekButtonView
           
        }
        .cornerRadius(15)
        .onAppear{
            updateCurCalendar()
        }
    }
    
}

extension CalendarView{
    
    func updateCurCalendar(){
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.locale = Locale(identifier: "zh_CH")
        
        let weekSymbol = gregorian.weekdaySymbols
        let monthSymbol = gregorian.monthSymbols
        
        
        let current = Calendar.current

        let day = current.component(.day, from: date)
        let year = current.component(.year, from: date)
        let monthId = current.component(.month, from: date) - 1
        let weekId = current.component(.weekday, from: date) - 1
        
        calendar = CalendarModel(date: date, day: "\(day)", week:"\(weekSymbol[weekId])" ,year: "\(year)", month: "\(monthSymbol[monthId])")
        
        
    }
    
    // MARK: MONTH
    private var monthView:some View{
        
        ZStack {
            
            // Text
            HStack{
                Spacer(minLength: 0)
                Text(calendar.month)
                    .foregroundColor(.theme.accent)
                    .accessibilityLabel(Text(calendar.readMonth()))
                Spacer()
            }
            
            monthButtonView
     
        }
    }
    
    private var monthButtonView:some View{
        
        HStack{
            Button {
                date = Calendar.current.date(byAdding: .month, value: -1, to: date) ?? Date()
                updateCurCalendar()
                
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundColor(Color.theme.gray)
                    
                   
            }
            .accessibilityLabel(Text("增加月份" + "当前" + calendar.readMonth()))

            
            Spacer()
            Button {
                date = Calendar.current.date(byAdding: .month, value: 1, to: date) ?? Date()
                updateCurCalendar()
            } label: {
                Image(systemName: "arrow.right")
                    .font(.title)
                    .foregroundColor(Color.theme.gray)
                   
            }
            .accessibilityLabel(Text("增加月份" + "当前" + calendar.readMonth()))

            

        }
        .padding(.horizontal,30)
       

    }
    
    // MARK: DAY & Week
    private var dayAndWeekView:some View{
        
        VStack{
            // 日
            Text(calendar.day)
                .font(.system(size:65))
                .fontWeight(.bold)
                .accessibilityLabel(Text("\(calendar.day)日"))
            // 周
            Text(calendar.week)
                .padding(.vertical)
        }
    }
    
    private var dayAndWeekButtonView:some View{
        HStack{
            Button {
                date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? Date()
                updateCurCalendar()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundColor(Color.theme.gray)
            }
            .accessibilityLabel(Text("向前一天" + "当前" + calendar.readMonthAndDay()))

            Spacer()
            Button {
                date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
                updateCurCalendar()
            } label: {
                Image(systemName: "arrow.right")
                    .font(.title)
                    .foregroundColor(Color.theme.gray)
            }
            .accessibilityLabel(Text("向后一天" + "当前" + calendar.readMonthAndDay()))


        }
        .padding(.horizontal,30)
    }
    
    // MARK: YEAR
    private var yearView:some View{
        // 年
        ZStack{
            
            Text(calendar.year)
                .padding(.vertical)
            
            
            HStack{
                Button {
                    date = Calendar.current.date(byAdding: .year, value: -1, to: date) ?? Date()
                    updateCurCalendar()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(Color.theme.gray)
                }
                .accessibilityLabel(Text("向前一年" + "当前" + calendar.readYear()))

                Spacer()
                Button {
                    date = Calendar.current.date(byAdding: .year, value: 1, to: date) ?? Date()
                    updateCurCalendar()
                } label: {
                    
                    Image(systemName: "arrow.right")
                        .font(.title)
                        .foregroundColor(Color.theme.gray)
                }
                .accessibilityLabel(Text("向后一年" + "当前" + calendar.readYear()))

            }
            .padding(.horizontal,30)
        }
      
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(date: .constant(Date()))
    }
}
