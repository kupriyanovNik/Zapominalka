//
//  MainView.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import SwiftUI
import RealmSwift

struct MainView: View {

    @ObservedResults(WordItem.self) var words
    @AppStorage("selectedTab") private var selectedTab: Tab = .words
    
    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        if !words.isEmpty {
            ZStack {
                switch selectedTab {
                case .words:
                    ContentView()
                case .game:
                    GameView()
                }
                TabBarMainView()
                    .padding(.bottom, 10)
                    .ignoresSafeArea(.keyboard)
                    .tint(.purple)
            }
        } else {
            EmptyWordsView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
