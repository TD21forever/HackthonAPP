//
//  DateModel.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import Foundation


struct DateModel: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var month: Int
    var year: Int
    var date: Date
}
