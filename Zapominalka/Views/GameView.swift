//
//  GameVeiw.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import SwiftUI
import RealmSwift

struct GameView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var isShowTranslation: Bool = false

    @ObservedResults(WordItem.self) var words

    @State var offsetX: CGFloat = .zero
    @State var offsetY: CGFloat = .zero
    @State var opacity: CGFloat = 1
    
    @State var word = WordItem()
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            MainBackground()
            VStack {
                currentWordView
                nextButton
                
            }
            .padding(.horizontal, 15)
            .onAppear {
                getRandowWord()
            }
            .frame(maxWidth: .infinity)
        }
    }
    private func getRandowWord() {
        if !words.isEmpty {
            self.word = words.randomElement()!
        } else {
            let newWord = WordItem()
            newWord.mainWord = "Placeholder"
            newWord.location = "Placeholder"
            newWord.wordTranslation = "Placeholder"
            self.word = newWord
        }
    }
    private var currentWordView: some View {
        VStack(spacing: 23) {
            Spacer()
            VStack(alignment: .leading) {
                Text(word.location)
                    .font(.system(size: 12, weight: .black))
                    .padding(.bottom, 0)
                Text(word.mainWord)
                    .font(.system(size: 36, weight: .black))
            }
            ZStack {
                Text(word.wordTranslation)
                    .font(.system(size: 26, weight: .thin))
                    .opacity(isShowTranslation ? 1 : 0)
                Button {
                    withAnimation {
                        self.isShowTranslation.toggle()
                    }
                } label: {
                    Text("Show translation")
                        .padding(.vertical, 13)
                        .padding(.horizontal, 60)
                        .foregroundColor(.white)
                        .background(Color("MAIN"))
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .opacity(!isShowTranslation ? 1 : 0)
                
            }
            Spacer()
        }
        .opacity(opacity)
        .offset(x: offsetX, y: offsetY)
    }
    private var nextButton: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    offsetX = 50
                    offsetY = 15
                    opacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    getRandowWord()
                    offsetX = -50
                    offsetY = 15
                    withAnimation {
                        self.isShowTranslation = false
                        offsetX = 0
                        offsetY = 0
                        opacity = 1
                    }
                }
            } label: {
                ZStack {
                    AnimatedGradient(colors: [.cyan, .purple, .green], duration: 3.0)
                        .clipShape(Circle())
                        .opacity(0.7)
                        .cornerRadius(20)
                    HStack(spacing: 0) {
                        Text("Next")
                        Image(systemName: "chevron.right").bold()
                    }
                    .foregroundColor(.white)
                    .font(.caption)
                }
                .shadow(color: .green.opacity(0.3), radius: 10)
            }
            .disabled(opacity == 0)
            .offset(x: -15, y: -15)
            .buttonStyle(.plain)
            .frame(width: 60, height: 60)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
