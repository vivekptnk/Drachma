//
//  HomeViewModel.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/11/21.
//

import Foundation

class HomeViewModel : ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.allCoins.append(DeveloperPreview.instance.coin)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
