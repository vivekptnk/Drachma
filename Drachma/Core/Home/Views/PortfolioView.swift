//
//  PortfolioView.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/19/21.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin : Coin? = nil
    @State private var quantityText : String = ""
    @State private var showCheckMark : Bool = false
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                }
                
                coinLogoList
                if selectedCoin != nil {
                    portfolioInputSection
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: { //navbaritems deprecated
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            })
            .onChange(of: vm.searchText, perform: { value in
                if value == "" {
                    removeSelectedCoin()
                }
            })
        }
        
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PortfolioView()
                .environmentObject(dev.homeVM)
                .colorScheme(.dark)
            PortfolioView()
                .environmentObject(dev.homeVM)
                .colorScheme(.light)
        }
    }
}


extension PortfolioView {
    private var coinLogoList : some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke((selectedCoin?.id == coin.id) ? Color.theme.green : Color.clear
                                        , lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}), let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
        
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection : some View {
        VStack(spacing: 20){
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount Holding: ")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value: ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith6Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButton : some View {
        HStack(spacing : 10){
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
            })
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )
            
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin,
              let amount = Double(quantityText)
        else {return}
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide check mars
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut){
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
