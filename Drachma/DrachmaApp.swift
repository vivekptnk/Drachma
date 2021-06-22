//
//  DrachmaApp.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/10/21.
//

import SwiftUI

@main
struct DrachmaApp: App {
    
    @State private var showLaunchView : Bool = true
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes =  [.foregroundColor: UIColor(Color.theme.accent)]
        
    }
    
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView{
                    HomeView()
                        .navigationBarHidden(true )
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(vm)
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                    
                }
                .zIndex(2.0)
                
            }
            
        }
    }
}
