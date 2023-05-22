//
//  CardItem.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import SwiftUI

struct CardItem: View {
    
    @State private var offsetX: CGFloat = 0
    @State private var showDescription: Bool = false
    
    var cardItem: WordItem
    
    var onDelete: () -> ()
    
    var body: some View {
        ZStack(alignment: .trailing) {
            RemoveImage()
            VStack(alignment: .leading, spacing: 10) {
                mainInformation
                if !cardItem.wordDescription.isEmpty && showDescription {
                    optionalInformation
                }
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    self.showDescription.toggle()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(Color("GRAY1").opacity(0.3))
            .cornerRadius(10)
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            offsetX = value.translation.width
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if screenSize().width * 0.7 < -value.translation.width {
                                offsetX = -screenSize().width
                                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                onDelete()
                            } else {
                                offsetX = .zero
                            }
                            
                        }
                    }
            )
        }
    }
    @ViewBuilder func RemoveImage() -> some View {
        Image(systemName: "xmark")
            .resizable()
            .frame(width: 10, height: 10)
            .offset(x: 30)
            .offset(x: offsetX * 0.6)
            .scaleEffect( CGSize(width: -offsetX * 0.005, height: -offsetX * 0.005) )
    }
    private var mainInformation: some View {
        VStack(alignment: .leading, spacing: 0) {
            if self.showDescription {
                Text(cardItem.location)
                    .font(.system(size: 12, weight: .black))
                    .padding(.bottom, 7)
            }
            Text(cardItem.mainWord)
                .font(.system(size: 18, weight: .black))
            Rectangle()
                .frame(height: 4)
                .opacity(0)
            Text(cardItem.wordTranslation)
                .font(.system(size: 18, weight: .light))
        }
    }
    private var optionalInformation: some View {
        VStack(alignment: .leading) {
            Divider()
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.system(size: 12, weight: .black))
                    .padding(.bottom, 2)
                    .foregroundColor(Color("GRAY1"))
                Text(cardItem.wordDescription)
            }
        }
    }
}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
