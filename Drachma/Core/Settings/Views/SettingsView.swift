//
//  SettingsView.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/20/21.
//

import SwiftUI

struct SettingsView: View {
    
    let personalURL = URL(string: "https://www.viwoke.dev")!
    let githubURL = URL(string: "https://www.github.com/vivekptnk")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/viwoke")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com/en")!
    
    var body: some View {
        NavigationView {
            List{
                personalSection
                coinGeckoSection
                developerSection
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
                .preferredColorScheme(.light)
            SettingsView()
                .preferredColorScheme(.dark)
        }
    }
}

extension SettingsView {
    private var personalSection : some View {
        
        Section(header: Text("Drachma")) {
            HStack(alignment: .center, spacing: 10) {
                Image("logo")
                    .resizable()
                    .background(Color.black)
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.vertical)
                Divider()
                    .padding()
                Text("This app was a personal project by Vivek. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
        }
        
    }
    
    private var coinGeckoSection : some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coinGeckoImage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("All data is from API provided by CoinGecko.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Check Out CoinGecko", destination: coinGeckoURL)
                .foregroundColor(.blue)
        }
    }
    
    private var developerSection : some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .center, spacing: 10) {
                Image("vivekpic")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Divider()
                    .padding()
                Text("This project is made by Vivek Pattanaik, it uses SwiftUI ❤️ and is written 100% in Swift ❤️. This project is heavily optimized because of the use of multi-threading, publishers/subscribers, and data persistence. \n\n If you liked this project and want to reach out to me, visit my website and shoot me an email.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Developer Github", destination: githubURL)
                .foregroundColor(.blue)
            Link("Buy me a Coffee", destination: coffeeURL)
                .foregroundColor(.blue)
            Link("Developer Website", destination: personalURL)
                .foregroundColor(.blue)
        }
    }
    
}
