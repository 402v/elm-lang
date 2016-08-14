//
//  PocketHelper.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/14.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class PocketHelper: NSObject {

    let fileHelper = FileHelper()

    func pocket(title: String, url: URL) -> Bool {
        let penny = Penny(title: title, url: url, createAt: Date())
        let filePath = fileHelper.elmPocketFilePath(url: url.absoluteString)

        return NSKeyedArchiver.archiveRootObject(penny, toFile: filePath)
    }

    func pockets() -> [Penny] {
        let pocketFileList = fileHelper.elmPocketFiles()

        var pennyList: [Penny] = Array()
        for pocketFileName in pocketFileList {
            let pocketFilePath = fileHelper.elmPocketFilePath(md5: pocketFileName)
            let penny = NSKeyedUnarchiver.unarchiveObject(withFile: pocketFilePath)
            print("penny:\(penny)")
            pennyList.append(penny as! Penny)
        }
        return pennyList
    }
}
