//
//  JavascriptHelper.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/15.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

enum ElmGuideJavascript: String {
    case openIndexJS = "document.getElementsByClassName(\"book font-size-2 font-family-1\")[0].className = \"book font-size-2 font-family-1 with-summary\""
    case closeIndexJS = "document.getElementsByClassName(\"book font-size-2 font-family-1 with-summary\")[0].className = \"book font-size-2 font-family-1\""
    case isIndexOpenJS = "document.getElementsByClassName(\"book font-size-2 font-family-1 with-summary\").length > 0"

    case prevPageJS = "document.getElementsByClassName(\"navigation navigation-prev \")[0].href"
    case nextPageJS = "document.getElementsByClassName(\"navigation navigation-next \")[0].href"

    case titleJS = "document.title"
    case urlJS = "document.URL"

    case hasPrevPageJS = "document.getElementsByClassName(\"navigation navigation-prev \").length > 0"
    case hasNextPageJS = "document.getElementsByClassName(\"navigation navigation-next \").length > 0"

    case scrollToBottomJS = "document.getElementsByClassName(\"navigation navigation-next \")[0]. scrollIntoView()"
}

class JavascriptHelper: NSObject {
//    let openIndexJS = "document.getElementsByClassName(\"book font-size-2 font-family-1\")[0].className += \" with-summary\""
//    let closeIndexJS = "document.getElementsByClassName(\"book font-size-2 font-family-1 with-summary\")[0].className -= \" with-summary\""
//
//    let prePageJS = "document.getElementsByClassName(\"navigation navigation-pre \")[0].href"
//    let nextPageJS = "document.getElementsByClassName(\"navigation navigation-next \")[0].href"
//
//    let titleJS = "document.title"
//    let urlJS = "document.URL"
}
