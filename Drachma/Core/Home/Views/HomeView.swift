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
            }
        }
        .listStyle(PlainListStyle())
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
        
    }
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(vm.portfolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingsColumn: true )
            }
        }
        .listStyle(PlainListStyle())
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
    }
    
    private var columnTitles : some View {
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
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
