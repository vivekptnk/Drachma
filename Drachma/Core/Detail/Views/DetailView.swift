//
//  DetailView.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/20/21.
//

import SwiftUI

struct DetailView: View {
    
    let coin : Coin
    
    init(coin: Coin) {
        self.coin = coin
        print("Initializing detailed view for : \(coin.name )")
    }
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
