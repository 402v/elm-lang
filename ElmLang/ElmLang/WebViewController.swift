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

    @IBAction func pocket() {
        // 
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.webView?.loadRequest(URLRequest(url: self.url!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
