//
//  AppConfigHandler.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/17.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class AppConfigHelper: NSObject {
    var shutdown: Bool = false
    var rootHost: String?
    var shutdownReason: String?

    func parseAppConfigs(data: Data?) -> Void {

        do {
            let jsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [ String: AnyObject ]

            if let shutdownValue = jsonDict?["shutdown"] {
                self.shutdown = shutdownValue.boolValue
            }

            if let rootHostValue = jsonDict?["root_host"] {
                self.rootHost = rootHostValue as? String
            }

            if let shutdownReasonValue = jsonDict?["shutdown_reason"] {
                self.shutdownReason = shutdownReasonValue as? String
            }
        } catch {
            print("parse app config failed!")
        }
    }
}
