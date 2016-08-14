//
//  Page.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/14.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class Page: NSObject {
    var id: String?
    var name: String?
    var location: URL?
    var publishedAt: String?

    init(id: String, name: String, location: URL, publishedAt: String) {
        self.name = name
        self.location = location
        self.publishedAt = publishedAt
    }
}
