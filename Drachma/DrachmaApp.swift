//
//  DrachmaApp.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/10/21.
//

import SwiftUI

@main
struct DrachmaApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true )
            }
            .environmentObject(vm)
        }
    }
}
