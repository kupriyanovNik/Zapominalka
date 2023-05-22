//
//  WordModel.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import Foundation
import RealmSwift

final class WordItem: Object, Identifiable { //ObjectKeyIdentifiable
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var location: String = "EN"
    @Persisted var mainWord: String = ""
    @Persisted var wordTranslation: String = ""
    @Persisted var wordDescription: String = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
}
