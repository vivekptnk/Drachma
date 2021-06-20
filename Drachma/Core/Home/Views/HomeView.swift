//
//  HomeView.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/10/21.
//

import SwiftUI



struct HomeView: View {
    
    @State private var showPortfolio : Bool = false // animate right
    @State private var showPortfolioView : Bool = false // show sheet
    @EnvironmentObject private var vm : HomeViewModel
    @State private var selectedCoin : Coin? = nil
    @State private var showDetailView : Bool = false
    
    var body: some View {
        ZStack{
            //background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            //content layer
            VStack{
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
                    .padding(.horizontal )
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio{
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                
                Spacer(minLength: 0)
            }
        }
        .background(
            NavigationLink(
                destination: DetailView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: {EmptyView()})
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
                    .colorScheme(.light)
            }
            .environmentObject(dev.homeVM)
        }
    }
    
    
    
}

extension HomeView {
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(CircleButtonAnimationView(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio":"Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List{
            ForEach(vm.allCoins){ coin in
                
                CoinRowView(coin: coin, showHoldingsColumn: false )
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                
                
            }
        }
        .listStyle(PlainListStyle())
        
        
    }
    
    private func segue(coin: Coin){
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(vm.portfolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingsColumn: true )
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
    }
    
    private var columnTitles : some View {
        HStack{
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .rank || vm.sortOptions == .rankReversed) ? 1.0: 0.0)
                    .rotationEffect(Angle(degrees: (vm.sortOptions == .rank) ? 0 : 180))
            }
            .onTapGesture {
                //                if vm.sortOptions == .rank {
                //                    vm.sortOptions = .rankReversed
                //                } else {
                //                    vm.sortOptions = .rank
                //                }
                withAnimation(.default){
                    vm.sortOptions = vm.sortOptions == .rank ? .rankReversed : .rank // shorter
                }
            }
            
            
            Spacer()
            if showPortfolio{
                HStack(spacing: 4) {
                    Text("Holdings")
                        .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOptions == .holdings || vm.sortOptions == .holdingsReversed) ? 1.0: 0.0)
                        .rotationEffect(Angle(degrees: (vm.sortOptions == .holdings) ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default){
                        vm.sortOptions = vm.sortOptions == .holdings ? .holdingsReversed : .holdings // shorter
                    }
                }
                
            }
            HStack(spacing: 4) {
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .price || vm.sortOptions == .priceReversed) ? 1.0: 0.0)
                    .rotationEffect(Angle(degrees: (vm.sortOptions == .price) ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOptions = vm.sortOptions == .price ? .priceReversed : .price // shorter
                }
            }
            
            Button(action: {
                withAnimation(.linear(duration: 2.0)){
                    vm.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
        }
    }
}
