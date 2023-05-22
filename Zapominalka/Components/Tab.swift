//
//  Tab.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import SwiftUI


struct TabBarMainView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .words
    var body: some View {
        VStack {
            Spacer()
            HStack {
                content
            }
            .padding(12)
            .background(Color("GRAY1").opacity(0.7))
            .background(.ultraThinMaterial)
            .mask {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
            }
            .shadow(color: Color("MAIN").opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 24)
            
        }
    }
    var content: some View {
        ForEach(tabItems) { item in
            Button {
                withAnimation(.spring()) {
                    selectedTab = item.tab
                }
            } label: {
                Image(systemName: item.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(selectedTab == item.tab ? 1 : 0.8)
                    .frame(width: 45)
                    .foregroundColor(.white)
                    .opacity(selectedTab == item.tab ? 1 : 0.6)
                    .background {
                        VStack {
                            RoundedRectangle(cornerRadius: 2)
                                .frame(width: selectedTab == item.tab ? 40 : 0, height: 5)
                                .offset(y: -10)
                                .foregroundColor(.purple)
                                .opacity(selectedTab == item.tab ? 1 : 0)
                            Spacer()
                        }
                    }
                    .padding(5)
            }
            .buttonStyle(.plain)
            
        }
    }
}

struct TabBarMainView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarMainView()
    }
}

struct TabItem: Identifiable {
    var id = UUID()
    var icon: String
    var tab: Tab
}

var tabItems: [TabItem] = [
    .init(icon: "list.dash", tab: .words),
    .init(icon: "gamecontroller", tab: .game)
]

enum Tab: String {
    case words
    case game
}
