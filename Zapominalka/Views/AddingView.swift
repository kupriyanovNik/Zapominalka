//
//  AddingView.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import SwiftUI
import RealmSwift

struct AddingView: View {
    @State private var newWord: String = ""
    @State private var wordTranslation: String = ""
    @State private var wordDescription: String = ""
    @State private var selectedLanguage: Languages = .en
    
    @State private var showAlert: Bool = false
    
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @ObservedResults(WordItem.self) var wordItems
    
    var body: some View {
        ZStack {
            MainBackground()
            VStack {
                navigationBar
                wordInformation
                Spacer()
                saveButton
            }
            .alert("Empty fields", isPresented: $showAlert) { }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(15)
        }
    }
    private var navigationBar: some View {
        HStack {
            Spacer()
            Text("New Word")
                .padding(.leading, 16)
                .font(.system(size: 20, weight: .black))
            
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            
        }
    }
    private var wordInformation: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selectedLanguage,
                   label: Text(selectedLanguage.title).foregroundColor(colorScheme == .dark ? .white : .black)) {
                ForEach(Languages.allCases, id: \.rawValue) { lang in
                    Text(lang.title).tag(lang)
                }
            }
                   .tint(colorScheme == .dark ? .white : .black)
            
            HStack {
                TextField("Word", text: $newWord)
                    .textInputAutocapitalization(.never)
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 23)
            .background(Color("GRAY1").opacity(0.3))
            .cornerRadius(10)
            
            HStack {
                TextField("Translation", text: $wordTranslation)
                    .textInputAutocapitalization(.never)
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 23)
            .background(Color("GRAY1").opacity(0.3))
            .cornerRadius(10)
            
            Text("Description")
                .font(.system(size: 14, weight: .black))
                .padding(.top, 23)
                .padding(.leading, 23)
            HStack {
                TextField("", text: $wordDescription, axis: .vertical)
                    .frame(height: 90)
                    .lineLimit(nil)
                    .textInputAutocapitalization(.never)
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 23)
            .background(Color("GRAY1").opacity(0.3))
            .cornerRadius(10)
            
        }
    }
    private var saveButton: some View {
        Button {
            if newWord.isEmpty || wordTranslation.isEmpty {
                self.showAlert.toggle()
            } else {
                let word = WordItem()
                word.mainWord = self.newWord.lowercased()
                word.wordTranslation = self.wordTranslation.lowercased()
                word.wordDescription = self.wordDescription
                word.location = self.selectedLanguage.title
                $wordItems.append(word)
                dismiss()
            }
        } label: {
            Text("Save")
                .padding(.vertical, 13)
                .frame(maxWidth: .infinity)
                .background(Color("MAIN"))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
}


struct AddingView_Previews: PreviewProvider {
    static var previews: some View {
        AddingView()
    }
}
