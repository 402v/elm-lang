//
//  WebViewController.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/14.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    var url : URL?

    @IBOutlet weak var backBtn: UIButton?
    @IBOutlet weak var forwardBtn: UIButton?
    @IBOutlet weak var refreshBtn: UIButton?
    @IBOutlet weak var openInSafariBtn: UIButton?

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

    @IBAction func refresh() {
        if (self.webView?.isLoading)! == false {
            self.webView?.reload()
        }
    }

    @IBAction func openInSafari() {
        if let url = self.url {
            UIApplication.shared.openURL(url)
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.updateButtons(force: true, enable: false)

        let iconSize: CGFloat = 18
        self.backBtn?.setFAIcon(icon: FAType.FAAngleLeft, iconSize: iconSize, forState: .normal)
        self.forwardBtn?.setFAIcon(icon: FAType.FAAngleRight, iconSize: iconSize, forState: .normal)
        self.refreshBtn?.setFAIcon(icon: FAType.FASpinner, iconSize: iconSize, forState: .normal)
        self.openInSafariBtn?.setFAIcon(icon: FAType.FASafari, iconSize: iconSize, forState: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.webView?.loadRequest(URLRequest(url: self.url!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - private
    func updateButtons(force: Bool, enable: Bool) -> Void {
        if force {
            self.backBtn?.isEnabled = (self.webView?.canGoBack)! && enable
            self.forwardBtn?.isEnabled = (self.webView?.canGoForward)! && enable

            self.refreshBtn?.isEnabled = enable
            self.openInSafariBtn?.isEnabled = enable
        } else {
            self.backBtn?.isEnabled = (self.webView?.canGoBack)!
            self.forwardBtn?.isEnabled = (self.webView?.canGoForward)!

            self.refreshBtn?.isEnabled = true
            self.openInSafariBtn?.isEnabled = true
        }
    }

    // MARK: - Rotate
    override var shouldAutorotate: Bool {
        get { return false }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get { return .portrait }
    }

    // MARK: - WebView
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let title: String = webView.documentTitle() {
            self.navigationItem.title = title
        }
        if let url = webView.documentURL() {
            self.url = URL(string: url)
        }

        self.updateButtons(force: false, enable: true)
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
