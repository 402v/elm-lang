//
//  FileHelper.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/15.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class FileHelper: NSObject {
    func elmPocketFilePath(url: String) -> String {
        let pocketRootPath = self.elmPocketRootPath()

//        let encodeURLStr = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        let pocketFilePath = pocketRootPath.appending("/\(url.md5())")

        if FileManager.default.fileExists(atPath: pocketFilePath) {
            try! FileManager.default.removeItem(atPath: pocketFilePath)
        }

//        let createSuccess = FileManager.default.createFile(atPath: pocketFilePath, contents: nil, attributes: nil)
//        print("create file \(pocketFilePath) success:\(createSuccess)")

        return pocketFilePath
    }

    func elmPocketRootPath() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
        let pocketRootPath = documentsPath.appending("/pocket")

        if FileManager.default.fileExists(atPath: pocketRootPath) == false {
            try! FileManager.default.createDirectory(atPath: pocketRootPath, withIntermediateDirectories: true, attributes: nil)
        }

        return pocketRootPath
    }

    func elmPocketFiles() -> [String] {
        return try! FileManager.default.contentsOfDirectory(atPath: self.elmPocketRootPath())
    }
}

extension String {
//    func sha1() -> String {
//        let data = self.data(using: String.Encoding.utf8)!
//        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
//        CC_SHA1(data.bytes, CC_LONG(data.count), &digest)
//        let hexBytes = map(digest) { String(format: "%02hhx", $0) }
//        return "".join(hexBytes)
//    }

    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()

        return String(format: hash as String)
    }
}
