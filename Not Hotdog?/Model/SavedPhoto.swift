//
//  SavedPhoto.swift
//  Not Hotdog?
//
//  Created by Michael Einman on 5/11/21.
//

import Foundation
import RealmSwift

class SavedPhoto : Object {
    @objc dynamic var title: String = ""
    @objc dynamic var dateCreated: Date?
}
