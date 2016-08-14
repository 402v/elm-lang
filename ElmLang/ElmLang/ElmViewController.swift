//
//  BrowseViewController.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/14.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class ElmViewController: UIViewController, UIWebViewDelegate {

    var url : URL?
    var hasAppear : Bool = false

    @IBOutlet weak var webView: UIWebView?

    @IBAction func goForward() {
        if (self.webView?.canGoForward)! {
            self.webView?.goForward()
        }
    }

    @IBAction func goBack() {
        if (self.webView?.canGoBack)! {
            self.webView?.goBack()
        }
    }

    @IBAction func share(sender: UIButton) {
        let iconImg = UIImage.init(named: "AppIcon60x60@2x.png")
        ShareHelper().callSystemShare(in: self, text: "Share from ElmLang App", url: (self.url?.absoluteString)!, image: iconImg!, sourceView: sender)
    }

    @IBAction func pocket() {
        let result = PocketHelper().pocket(title: self.navigationItem.title!, url: self.url!)
        print("pocket result: \(result)")
    }

    @IBAction func index() {
        //
    }

    @IBAction func scrollToBottom() {
//        let height = Int((webView?.stringByEvaluatingJavaScript(from:"document.body.offsetHeight;"))!)
//        let scrollScript = "window.scrollBy(0, \(height!));"

        let scrollScript = "window.scrollBy(0, 1599);"
        let _ = webView?.stringByEvaluatingJavaScript(from: scrollScript)
    }

    // MARK: - WebView
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {

        let sameDomain = request.url?.sameSubdomain(with: self.url!)
        print("webview request: \(request.url) same domain: \(sameDomain)")

        if !sameDomain! {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let webVC = storyboard.instantiateViewController(withIdentifier: "WebVCIdentifier") as! WebViewController
//            let webVC = WebViewController(nibName: "WebVCIdentifier", bundle: nil)
            webVC.url = request.url
            self.navigationController?.show(webVC, sender: self)
        } else {
            self.url = request.url
        }

        return sameDomain!
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.navigationItem.title = webView.title()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any a dditional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if self.hasAppear == false {
            self.webView?.loadRequest(URLRequest(url: self.url!))
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if self.hasAppear == false {
            self.hasAppear = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Rotate
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
