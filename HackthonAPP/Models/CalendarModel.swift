//
//  Calendar.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import Foundation



// 日历
struct CalendarModel {
    var date: Date
    var day: String
    var week: String
    var year: String
    var month: String
    
    func readMonthAndDay()->String {
        return "\(month)\(day)\(week)"
    }
    
    func readYear()->String{
        return "\(year)年"

    }
    
    func readMonth()->String{
        return "\(month)"

    }
    
    
}
