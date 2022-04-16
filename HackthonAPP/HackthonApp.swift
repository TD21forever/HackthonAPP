//
//  HackthonAPPApp.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import SwiftUI

@main
struct HackthonApp: App {
    @StateObject var homeViewModel:HomeViewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeViewModel)
        }
    }
}
