//
//  Year.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/19.
//

import Foundation
import RealmSwift

class Year: Object {
    @objc dynamic var displayName: Int = 2022
    let stories = List<Story>()
}

class Story: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var periodflag: Bool = false
    @objc dynamic var start: Date? = nil
    @objc dynamic var end: Date? = nil
    @objc dynamic var when: Date!
    @objc dynamic var memo: String = ""
    @objc dynamic var photo: String = ""
}
