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
}
