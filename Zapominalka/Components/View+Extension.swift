//
//  View+Extension.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import Foundation
import SwiftUI

extension View {
    func screenSize() -> CGSize {
        guard
            let window = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return .zero }
        return window.screen.bounds.size
    }
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
