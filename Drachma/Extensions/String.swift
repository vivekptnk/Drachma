//
//  String.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/20/21.
//

import Foundation

extension String {
    var removingHTMLOccurences : String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
