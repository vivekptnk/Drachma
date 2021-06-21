//
//  Color.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/10/21.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
    
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let red = Color("RedColor")
    let green = Color("GreenColor")
    let secondaryText = Color("SecondaryTextColor")
    let titleColor = Color("TitleColor")
}

struct LaunchTheme {
    let launchBackground = Color("LaunchBackgroundColor")
    let launchAccent = Color("LaunchAccentColor")
}
