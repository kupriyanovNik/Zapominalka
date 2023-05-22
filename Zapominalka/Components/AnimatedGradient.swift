//
//  AnimatedGradient.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import SwiftUI

struct AnimatedGradient: View {
    
    @State private var start = UnitPoint(x: 0, y: 0)
    @State private var end = UnitPoint(x: 0, y: 2)
    
    let colors: [Color]
    var duration: Double = 7.0
    
    var body: some View {
        LinearGradient(colors: colors, startPoint: start, endPoint: end)
            .onAppear {
                withAnimation (.easeInOut(duration: duration).repeatForever()) {
                    self.start = UnitPoint(x: 1, y: -1)
                    self.end = UnitPoint(x: 0, y: 1)
                }
            }
    }
}

struct MainBackground: View {
    @Environment(\.colorScheme) var colorScheme
    var colors: [Color] = [.cyan, .purple, .green]
    var body: some View {
        AnimatedGradient(colors: colors)
            .ignoresSafeArea()
            .opacity(colorScheme == .dark ? 0.3 : 0.15)
    }
}
