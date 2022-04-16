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
        let current = Calendar.current

        let day = current.component(.day, from: date)
        let year = current.component(.year, from: date)
        let month = current.component(.month, from: date)
        let week = current.component(.weekday, from: date)
        
        calendar = CalendarModel(date: date, day: "\(day)", week:"\(week)" ,year: "\(year)", month: "\(month)")
        
        
    }
    
    // MARK: MONTH
    private var monthView:some View{
        
        ZStack {
            
            // Text
            HStack{
                Spacer(minLength: 0)
                Text(calendar.month + " 月")
                    .foregroundColor(.theme.accent)
                Spacer()
            }
            .padding(.top,40)
            .background(Color.theme.red)
            
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
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.black)
            }
            Spacer()
            Button {
                date = Calendar.current.date(byAdding: .month, value: 1, to: date) ?? Date()
                updateCurCalendar()
            } label: {
                Image(systemName: "arrow.right")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.black)
            }

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
            // 周
            Text("星 期 "+calendar.week)
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
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.black)
            }
            Spacer()
            Button {
                date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
                updateCurCalendar()
            } label: {
                Image(systemName: "arrow.right")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.black)
            }

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
                        .font(.largeTitle)
                        .foregroundColor(Color.theme.black)
                }
                Spacer()
                Button {
                    date = Calendar.current.date(byAdding: .year, value: 1, to: date) ?? Date()
                    updateCurCalendar()
                } label: {
                    
                    Image(systemName: "arrow.right")
                        .font(.largeTitle)
                        .foregroundColor(Color.theme.black)
                }

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
