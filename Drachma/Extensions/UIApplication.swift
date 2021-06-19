//
//  UIApplication.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/19/21.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
