//
//  HomeVIew.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm:HomeViewModel

    @State var date:Date = Date()
    
    var body: some View {
        
        VStack{
            
            CalendarView(date: $date)
            Divider()
            ListView(date: $date)
        }
        .ignoresSafeArea()
        .onAppear {
            NotificationManager.instance.reloadAuthorizationStatus()
        }
        .onChange(of: NotificationManager.instance.authorizationStatus , perform: performauthorizationStatus)

    }
}

extension HomeView{
    
    private func performauthorizationStatus(authorizationStatus: UNAuthorizationStatus?){
        switch authorizationStatus {
        case .notDetermined:
            NotificationManager.instance.requestAuthorization()
        case .authorized:
            NotificationManager.instance.reloadLocalNotifications()
        break
        default:
            break
        }
        
    }
}

struct HomeVIew_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
