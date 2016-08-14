//
//  PageController.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/14.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class PageHelper: NSObject {
    func parsePageList(data: Data?) -> [String: Page] {
        var jsonAry: Array<AnyObject>!
        var pageList : [String: Page] = Dictionary()

        do {
            jsonAry = try JSONSerialization.jsonObject(with: data!, options: []) as? Array

            for jsonDict in jsonAry {

                let pageIDStr = jsonDict["page_id"] as! String
                let locationStr = jsonDict["location"] as! String
                let location = URL(string: locationStr)

                let publishedAtStr = jsonDict["published_at"] as! String

                let page = Page(id: pageIDStr,
                                name: jsonDict["name"] as! String,
                                location: location!,
                                publishedAt: publishedAtStr)
                pageList[pageIDStr] = page
            }
        } catch {
            print(jsonAry)
        }

        return pageList
    }

    func pageURL(title: String?, pageList: [String: Page]) -> URL? {

        var url : URL?

        switch title! {
        case "Get Started":
            url = pageList["get_started"]!.location
            break
        case "Pocket":
            break
        case "Playgrounds":
            break
        case "Examples":
            break
        default:
            print("wrong button title!")
            break
        }

        return url
    }
}
