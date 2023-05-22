//
//  EmptyWordsView.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import SwiftUI

struct EmptyWordsView: View {
    @State private var showAddingView: Bool = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            MainBackground()
            welcomeText
            nextButton
        }
        .sheet(isPresented: $showAddingView) {
            AddingView()
        }
    }
    private var welcomeText: some View {
        Text("Tap \"+\" to\nadd first word")
            .foregroundColor(.white)
            .bold()
            .lineLimit(nil)
            .multilineTextAlignment(.center)
            .padding(25)
            .background(
                AnimatedGradient(colors: [.mint, .indigo, .pink], duration: 2)
                    .opacity(0.5)
            )
            .cornerRadius(20)
    }
    private var nextButton: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button {
                    self.showAddingView.toggle()
                } label: {
                    ZStack {
                        AnimatedGradient(colors: [.cyan, .purple, .green], duration: 5.0)
                            .clipShape(Circle())
                            .opacity(0.7)
                            .cornerRadius(20)
                        Text("+")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .offset(x: -30, y: -15)
                .buttonStyle(.plain)
                .frame(width: 60, height: 60)
            }
        }
    }
}

struct EmptyWordsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyWordsView()
    }
}
