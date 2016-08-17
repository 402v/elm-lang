//
//  JavascriptHelper.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/15.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class JavascriptHelper: NSObject {

    var openIndexJS = "document.getElementsByClassName(\"book font-size-2 font-family-1\")[0].className = \"book font-size-2 font-family-1 with-summary\""
    var closeIndexJS = "document.getElementsByClassName(\"book font-size-2 font-family-1 with-summary\")[0].className = \"book font-size-2 font-family-1\""
    var isIndexOpenJS = "document.getElementsByClassName(\"book font-size-2 font-family-1 with-summary\").length > 0"

    var prevPageJS = "document.getElementsByClassName(\"navigation navigation-prev \")[0].href"
    var nextPageJS = "document.getElementsByClassName(\"navigation navigation-next \")[0].href"

    var hasPrevPageJS = "document.getElementsByClassName(\"navigation navigation-prev \").length > 0"
    var hasNextPageJS = "document.getElementsByClassName(\"navigation navigation-next \").length > 0"

    var scrollToBottomJS = "document.getElementsByClassName(\"navigation navigation-next \")[0]. scrollIntoView()"

    // MARK: - Singleton
    class var sharedInstance : JavascriptHelper {
        struct Static {
            static let instance : JavascriptHelper = JavascriptHelper()
        }
        return Static.instance
    }

    // MARK: - private
    func encodeJavascripts() -> Void {
        print("\"open_index_js\": \"\(self.openIndexJS.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)\",")
        print("\"close_index_js\": \"\(self.closeIndexJS.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)\",")
        print("\"is_index_open_js\": \"\(self.isIndexOpenJS.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)\",")
        print("\"prev_page_js\": \"\(self.prevPageJS.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)\",")
        print("\"next_page_js\": \"\(self.nextPageJS.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)\",")
        print("\"has_prev_page_js\": \"\(self.hasPrevPageJS.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)\",")
        print("\"has_next_page_js\": \"\(self.hasNextPageJS.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)\",")
        print("\"scroll_to_bottom_js\": \"\(self.scrollToBottomJS.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)\",")
    }

    func parseDecodeValue(of key: String ,in jsonDict: [ String: AnyObject ]?, for rawString: String) -> String {
        if let value: String = jsonDict?[key] as? String {
            if let decodeValue: String = value.removingPercentEncoding {
                return decodeValue
            }
        }
        return rawString
    }

    // MARK: - public
    func parseJavascripts(data: Data?) -> Void {
        do {
//            self.deencodeJavascripts()

            let jsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [ String: AnyObject ]

            self.openIndexJS = self.parseDecodeValue(of: "open_index_js", in: jsonDict, for: openIndexJS)
            self.closeIndexJS = self.parseDecodeValue(of: "close_index_js", in: jsonDict, for: closeIndexJS)
            self.isIndexOpenJS = self.parseDecodeValue(of: "is_index_open_js", in: jsonDict, for: isIndexOpenJS)
            self.prevPageJS = self.parseDecodeValue(of: "prev_page_js", in: jsonDict, for: prevPageJS)
            self.nextPageJS = self.parseDecodeValue(of: "next_page_js", in: jsonDict, for: nextPageJS)
            self.hasPrevPageJS = self.parseDecodeValue(of: "has_prev_page_js", in: jsonDict, for: hasPrevPageJS)
            self.hasNextPageJS = self.parseDecodeValue(of: "has_next_page_js", in: jsonDict, for: hasNextPageJS)
            self.scrollToBottomJS = self.parseDecodeValue(of: "scroll_to_bottom_js", in: jsonDict, for: scrollToBottomJS)

        } catch {
            print("parse javascript failed!")
        }
    }
}

extension UIWebView {
    // MARK: - Index
    func openGitBookIndex() -> String? {
        return self.stringByEvaluatingJavaScript(from: JavascriptHelper.sharedInstance.openIndexJS)
    }

    func closeGitBookIndex() -> String? {
        return self.stringByEvaluatingJavaScript(from: JavascriptHelper.sharedInstance.closeIndexJS)
    }

    func isGitBookIndexOpen() -> Bool? {
        if let result: String = self.stringByEvaluatingJavaScript(from: JavascriptHelper.sharedInstance.isIndexOpenJS) {
            return result == "true"
        } else {
            return nil
        }
    }

    // MARK: - Page
    func goNextGitBookPage() -> Bool {
        if let nextHref = self.stringByEvaluatingJavaScript(from: JavascriptHelper.sharedInstance.nextPageJS) {

            if let url = URL(string: nextHref) {
                self.loadRequest(URLRequest(url: url))
                return true
            }
        }

        return false
    }

    func goPrevGitBookPage() -> Bool {
        if let prevHref = self.stringByEvaluatingJavaScript(from: JavascriptHelper.sharedInstance.prevPageJS) {

            if let url = URL(string: prevHref) {
                self.loadRequest(URLRequest(url: url))
                return true
            }
        }

        return false
    }

    func hasGitBookPrevPage() -> Bool? {
        if let result: String = self.stringByEvaluatingJavaScript(from: JavascriptHelper.sharedInstance.hasPrevPageJS) {
            return result == "true"
        } else {
            return nil
        }
    }

    func hasGitBookNextPage() -> Bool? {
        if let result: String = self.stringByEvaluatingJavaScript(from: JavascriptHelper.sharedInstance.hasNextPageJS) {
            return result == "true"
        } else {
            return nil
        }
    }

    // MARK: - Scroll
    func scrollGitBookToBottom() -> Bool {
        if let hasNext: Bool = self.hasGitBookNextPage() {
            if hasNext {
                let _ = self.stringByEvaluatingJavaScript(from: JavascriptHelper.sharedInstance.scrollToBottomJS)
                return true
            }
        }
        return false
    }
}
