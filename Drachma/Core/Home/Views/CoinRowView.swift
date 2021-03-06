//
//  CoinRowView.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/10/21.
//

import SwiftUI

struct CoinRowView: View {
    let coin : Coin
    let showHoldingsColumn : Bool
    var body: some View {
        HStack(spacing: 0){
            leftColumn
            Spacer()
            if showHoldingsColumn == true {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .background(
            Color.theme.background
                .opacity(0.001)
        )
        
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension CoinRowView {
    private var leftColumn : some View {
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn : some View {
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
//        .offset(x: -10)
    }
    
    private var rightColumn : some View {
        HStack {
            VStack(alignment: .trailing){
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .bold()
                    .foregroundColor(Color.theme.accent)
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0) >= 0 ?
                            Color.theme.green :
                            Color.theme.red )
            }
            .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
            
            Image(systemName: "chevron.right.square.fill")
                .foregroundColor(Color.theme.titleColor)
                .padding(.all, 0)
        }
    }
}
