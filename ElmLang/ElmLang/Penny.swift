//
//  Penny.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/15.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

enum PennyCoderKeys: String {
    case title = "penny_title"
    case url = "penny_url"
    case createAt = "penny_create_at"
}

class Penny: NSObject, NSCoding {

    var title: String?
    var url: URL?
    var createAt: Date?

    init(title: String, url: URL, createAt: Date) {
        self.title = title
        self.url = url
        self.createAt = createAt
    }

    // MARK: - Coding
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: PennyCoderKeys.title.rawValue) as? String
        self.url = aDecoder.decodeObject(forKey: PennyCoderKeys.url.rawValue) as? URL
        self.createAt = aDecoder.decodeObject(forKey: PennyCoderKeys.createAt.rawValue) as? Date
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: PennyCoderKeys.title.rawValue)
        aCoder.encode(self.url, forKey: PennyCoderKeys.url.rawValue)
        aCoder.encode(self.createAt, forKey: PennyCoderKeys.createAt.rawValue)
    }
}
