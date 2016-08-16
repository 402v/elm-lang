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

    lazy var pennyHash: [URL: Penny]? = {
        let fileHelper = FileHelper()
        let pocketFileList = fileHelper.elmPocketFiles()

        var pennyHash: [URL: Penny] = Dictionary()

        for pocketFileName in pocketFileList {
            let pocketFilePath = fileHelper.elmPocketFilePath(md5: pocketFileName)

            if let penny = NSKeyedUnarchiver.unarchiveObject(withFile: pocketFilePath) as? Penny {
                if let url = penny.url {
                    pennyHash[url] = penny
                }
            }
        }

        return pennyHash
    }()

    func hasPocket(url: URL) -> Bool {
        if (self.pennyHash != nil) {
            return self.pennyHash![url] != nil
        } else {
            return false
        }
    }

    func pocket(title: String, url: URL) -> Bool {
        let penny = Penny(title: title, url: url, createAt: Date())
        let filePath = fileHelper.elmPocketFilePath(url: url.absoluteString)

        return NSKeyedArchiver.archiveRootObject(penny, toFile: filePath)
    }

    func unpocket(title: String, url: URL) -> Bool {
        if (self.pennyHash != nil) {
            if let _ = self.pennyHash![url] {
                let filePath = fileHelper.elmPocketFilePath(url: url.absoluteString)

                // remove from file
                try! FileManager.default.removeItem(atPath: filePath)

                // remove from memory
                let _ = self.pennyHash?.removeValue(forKey: url)
            }
        }

        return false
    }

    func pockets() -> [Penny] {
        let pocketFileList = fileHelper.elmPocketFiles()

        var pennyList: [Penny] = Array()
        var pennyHash: [URL: Penny] = Dictionary()

        for pocketFileName in pocketFileList {
            let pocketFilePath = fileHelper.elmPocketFilePath(md5: pocketFileName)

            if let penny = NSKeyedUnarchiver.unarchiveObject(withFile: pocketFilePath) as? Penny {
                print("penny:\(penny)")

                pennyList.append(penny)
                if let url = penny.url {
                    pennyHash[url] = penny
                }
            }
        }

        self.pennyHash = pennyHash
        return pennyList
    }
}
