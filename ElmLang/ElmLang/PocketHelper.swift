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

    func pocket(url: URL) -> Bool {
        let penny = Penny(url: url, createAt: Date())
        let filePath = fileHelper.elmPocketFilePath(url: url.absoluteString)

        return NSKeyedArchiver.archiveRootObject(penny, toFile: filePath)
    }

    func pockets() -> [Penny] {
        let pocketFileList = fileHelper.elmPocketFiles()

        var pennyList: [Penny] = Array()
        for pocketFile in pocketFileList {
            let penny = NSKeyedUnarchiver.unarchiveObject(withFile: pocketFile) as! Penny
            pennyList.append(penny)
        }
        return pennyList
    }
}
