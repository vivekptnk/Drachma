//
//  LaunchView.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/21/21.
//

import SwiftUI

struct LaunchView: View {
    @State private var percentage : CGFloat = 0.0
    @State private var finalPercent : CGFloat = 0.0
    @State private var showDrachma : Bool = false
    @State private var showAnimation : Bool = false
    @Binding var showLaunchView : Bool
    var body: some View {
        ZStack{
            Color.launch.launchBackground
                .ignoresSafeArea()
            VStack{
                imageAndCircle
                withAnimation() {
                    Text("DRACHMA")
                        .font(.system(size: 30))
                        .fontWeight(.black)
                        .foregroundColor(Color.launch.launchAccent)
                        .tracking(6)
                        .opacity(showDrachma ? 1 : 0 )
                        .offset(y: -60)
                }
                
            }
        }
        .onAppear{
            onAppearAnimation()
            
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}

extension LaunchView {
    
    private var drachmaText : some View {
            Text("hi")
    }
    
    private var imageAndCircle : some View {
        ZStack {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .butt, lineJoin: .miter))
                .foregroundColor(Color.launch.launchAccent)
                .frame(width: 300, height: 300, alignment: .center)
                .rotationEffect(Angle(degrees: -90))
                .opacity((showAnimation) ? 1 : 0)
        }
    }
    
    private func onAppearAnimation() {
        showAnimation.toggle()
        if percentage == 1.0 {
            showAnimation = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.spring(response: 1, dampingFraction: 3, blendDuration: 5)){
                percentage = 1.0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            withAnimation(){
                showAnimation.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.4) {
            withAnimation(){
                showDrachma.toggle()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.5) {
            withAnimation(){
                showLaunchView = false
            }
        }
    }
}
