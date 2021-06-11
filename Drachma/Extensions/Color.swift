//
//  Color.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/10/21.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let red = Color("RedColor")
    let green = Color("GreenColor")
    let secondaryText = Color("SecondaryTextColor")
}
