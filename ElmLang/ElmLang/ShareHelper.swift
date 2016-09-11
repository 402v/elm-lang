//
//  ShareHelper.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/14.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class ShareHelper: NSObject {
    func callSystemShare(in hostVC: UIViewController,
                         text: String,
                         url: String,
                         image: UIImage,
                         sourceView: UIView) -> Void {

        /// 分享文字图片信息，ipad上会以sourceView为焦点弹出选择视图
        let objectsToShare = [text, url, image] as [Any]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            hostVC.present(activityViewController, animated: true, completion: nil)
        } else {
            let popover = activityViewController.popoverPresentationController
            if (popover != nil) {
                popover?.sourceView = sourceView
                popover?.sourceRect = sourceView.frame
                popover?.permittedArrowDirections = UIPopoverArrowDirection.any
                hostVC.present(activityViewController, animated: true, completion: nil)
            }
        }
    }

    /// 在app内以子视图方式打开其他app预览，仅支持6.0以上
//    func openAppWithIdentifier(appId: String) {
//        if let _ = NSClassFromString("SKStoreProductViewController") {
//            let storeProductViewController = SKStoreProductViewController()
//            storeProductViewController.delegate = self
//            let dict = NSDictionary(object:appId, forKey:SKStoreProductParameterITunesItemIdentifier) as! [String : AnyObject]
//            storeProductViewController.loadProductWithParameters(dict, completionBlock: { (result, error) -> Void in
//                //  self.presentViewController(storeProductViewController, animated: true, completion: nil)
//            })
//            self.presentViewController(storeProductViewController, animated: true, completion: nil)
//        }else {
//            UIApplication.sharedApplication().openURL(NSURL(string: "itms-apps://itunes.apple.com/app/id/(appId)")!)
//        }
//    }
}
