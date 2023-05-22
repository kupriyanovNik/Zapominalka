//
//  ContentView.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State private var searchText: String = ""
    
    @State private var showAddingView: Bool = false
    @State private var showSearchField: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedResults(WordItem.self, sortDescriptor: SortDescriptor(keyPath: "mainWord", ascending: true)) var words
    
    var body: some View {
        ZStack(alignment: .trailing) {
            MainBackground()
            
            VStack {
                searchBar
                    .searchable(text: $searchText, collection: $words, keyPath: \.mainWord)
                wordCards
            }
                
            plusButton
        }
        .sheet(isPresented: $showAddingView) {
            AddingView()
        }
    }
    private var searchBar: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.3)) {
                            endEditing()
                            self.showSearchField.toggle()
                            self.searchText = ""
                        }
                    }
                if showSearchField {
                    TextField("Search", text: $searchText)
                        .textInputAutocapitalization(.never)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                        .opacity(showSearchField ? 1 : 0)
                        .frame(height: 15)
                } else {
                    Text("Words count: \(words.count)")
                        .opacity(!showSearchField ? 1 : 0)
                        .frame(height: 15)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(Color("GRAY1").opacity(0.3))
            .cornerRadius(10)
        }
        .padding(.top)
        .padding(.horizontal, 10)
        
    }
    private var wordCards: some View {
        ScrollView(showsIndicators: false) {
            ForEach(words) { word in
                CardItem(cardItem: word) {
                    withAnimation(.spring()) {
                        $words.remove(word)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
    }
    private var plusButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        endEditing()
                    }
                    self.showAddingView.toggle()
                } label: {
                    ZStack {
                        AnimatedGradient(colors: [.cyan, .purple, .green], duration: 3.0)
                            .clipShape(Circle())
                            .opacity(0.7)
                            .cornerRadius(20)
                        Text("+")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .shadow(color: .green.opacity(0.3), radius: 10)
                }
                .offset(x: -30, y: -15)
                .buttonStyle(.plain)
                .frame(width: 60, height: 60)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
