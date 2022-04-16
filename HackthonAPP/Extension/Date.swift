//
//  Date.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import Foundation

extension Date{
    
    func getOneMonthDates()->[Date]{
        let calendar = Calendar.current
        
        guard let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else { return [] }
        
        // 从startDate开始的一个月
        guard var range = calendar.range(of: .day, in: .month, for: startDate) else {return []}
        range.removeLast()
        return range.compactMap({ day -> Date in
            
            guard let calendarDate = calendar.date(byAdding: .day, value: day == 1 ? 0 : day-1, to: startDate) else {return startDate}
            
                    return calendarDate
        })
    }
    
    func isSameDay(date:Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
    
    private var shortFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    private var chFormatter: DateFormatter{
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_hans_CN")
        formatter.timeZone = TimeZone(identifier: "CCD")
        formatter.setLocalizedDateFormatFromTemplate("dd MMM hh.mm")

        return formatter
    }
    
    func chString()->String{
        return chFormatter.string(from: self)
    }
    
    func readableString(format: String) -> String {
        
            //"dd MMM hh.mm" 1月20日 上午11:10
           let formatter = DateFormatter()
           formatter.setLocalizedDateFormatFromTemplate(format)
           formatter.locale = Locale.current
           return formatter.string(from: self)
       }
    
 
}
