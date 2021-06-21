//
//  ChartView.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/20/21.
//

import SwiftUI

struct ChartView: View {
    
    private let data : [Double]
    private let maxY : Double
    private let minY : Double
    let lineColor : Color
    private let startingDate : Date
    private let endingDate : Date
    @State private var percentage: CGFloat = 0
    
    init(coin: Coin) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0 ) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    
    // 300
    // 100
    // 300 / 100
    // x = 3 pts
    
    // 1 * 3 = 3
    // 2 * 3 = 6
    // 3 * 3 = 9
    // ....
    // 100 * 3 = 300
    
    // 60000
    // 50000
    // 60000 - 50000 = 10000 -> yaxis
    // 50000 - data point
    // 52000 - 50000 - 2000 / 10000  = 20 percentoff the bottom
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(
                    chartBackground
                )
                .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)){
                    percentage = 1.0
                }
            }
        }
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
//            .frame(width: 200)
    }
}


extension ChartView {
    
    private var chartView : some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index) + 1
                    
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: 0, y: yPosition))
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 30)
        }
    }
    
    private var chartBackground : some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis : some View {
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
            
        }
    }
    
    private var chartDateLabels : some View {
        HStack{
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
