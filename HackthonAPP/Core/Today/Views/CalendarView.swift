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
          
                yearView

                
                monthView
                
                Divider()
                        
                dayAndWeekView
   
               
                
                
           
            }
            .font(.title)
            
            dayAndWeekButtonView
           
        }
        .background(Color.theme.gray.opacity(0.08).ignoresSafeArea())
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
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .font(.title)
                    .foregroundColor(Color.theme.gray)
                    
                   
            }
            .accessibilityLabel(Text("????????????" + "??????" + calendar.readMonth()))

            
            Spacer()
            Button {
                date = Calendar.current.date(byAdding: .month, value: 1, to: date) ?? Date()
                updateCurCalendar()
            } label: {
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .font(.title)
                    .foregroundColor(Color.theme.gray)
                   
            }
            .accessibilityLabel(Text("????????????" + "??????" + calendar.readMonth()))

            

        }
        .padding(.horizontal,30)
       

    }
    
    // MARK: DAY & Week
    private var dayAndWeekView:some View{
        
        VStack{
            // ???
            Text(calendar.day)
                .font(.system(size:65))
                .fontWeight(.bold)
                .accessibilityLabel(Text("\(calendar.day)???"))
            // ???
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
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .font(.title)
                    .foregroundColor(Color.theme.gray)
            }
            .accessibilityLabel(Text("????????????" + "??????" + calendar.readMonthAndDay()))

            Spacer()
            Button {
                date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
                updateCurCalendar()
            } label: {
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .font(.title)
                    .foregroundColor(Color.theme.gray)
            }
            .accessibilityLabel(Text("????????????" + "??????" + calendar.readMonthAndDay()))


        }
        .padding(.horizontal,30)
    }
    
    // MARK: YEAR
    private var yearView:some View{
        // ???
        ZStack{
            
            Text(calendar.year)
                .padding(.vertical)
            
            
            HStack{
                Button {
                    date = Calendar.current.date(byAdding: .year, value: -1, to: date) ?? Date()
                    updateCurCalendar()
                } label: {
                    Image(systemName: "arrowshape.turn.up.left.fill")
                        .font(.title)
                        .foregroundColor(Color.theme.accent)
                }
                .accessibilityLabel(Text("????????????" + "??????" + calendar.readYear()))

                Spacer()
                Button {
                    date = Calendar.current.date(byAdding: .year, value: 1, to: date) ?? Date()
                    updateCurCalendar()
                } label: {
                    
                    Image(systemName: "arrowshape.turn.up.right.fill")
                        .font(.title)
                        .foregroundColor(Color.theme.accent)
                }
                .accessibilityLabel(Text("????????????" + "??????" + calendar.readYear()))

            }
            .padding(.horizontal,30)
        }
        .frame(height:80)
        .background(Color.theme.orange.opacity(0.8))
      
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(date: .constant(Date()))
    }
}
