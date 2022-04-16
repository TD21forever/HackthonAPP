//
//  Date.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import Foundation

extension Date{
    
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
//        formatter.dateStyle = .short
//        formatter.timeStyle = .short
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
