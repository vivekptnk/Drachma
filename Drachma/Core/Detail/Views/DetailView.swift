//
//  DetailView.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/20/21.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var coin : Coin?
    
    init(coin: Binding<Coin?>) {
        self._coin = coin
        print("Initializing detailed view for : \(coin.wrappedValue?.name )")
    }
    
    var body: some View {
        Text(coin?.name ?? "")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: .constant(dev.coin))
    }
}
