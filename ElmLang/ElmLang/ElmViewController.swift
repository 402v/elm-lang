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
    @IBOutlet weak var indexBtn: UIButton?
    @IBOutlet weak var prevBtn: UIButton?
    @IBOutlet weak var nextBtn: UIButton?
    @IBOutlet weak var pocketBtn: UIButton?
    @IBOutlet weak var shareBtn: UIButton?
    @IBOutlet weak var scrollToBottomBtn: UIButton?

    let pocketHelper = PocketHelper()
    let toolbarIconSize: CGFloat = 18

    @IBAction func goForward() {
        if let hasNext = self.webView?.hasGitBookNextPage() {
            if hasNext {
                let _ = self.webView?.goNextGitBookPage()
                self.updatePocketBtnIcon()
            }
        }
    }

    @IBAction func goBack() {
        if let hasPrev = self.webView?.hasGitBookPrevPage() {
            if hasPrev {
                let _ = self.webView?.goPrevGitBookPage()
                self.updatePocketBtnIcon()
            }
        }
    }

    @IBAction func share(sender: UIButton) {
        let iconImg = UIImage.init(named: "AppIcon60x60@2x.png")
        ShareHelper().callSystemShare(in: self, text: "Share from ElmLang App", url: (self.url?.absoluteString)!, image: iconImg!, sourceView: sender)
    }

    @IBAction func pocket() {

        if let urlString: String = self.webView?.documentURL() {
            if let title: String = self.webView?.documentTitle(),
                let url: URL = URL(string: urlString) {

                if pocketHelper.hasPocket(url: url) {
                    let result = pocketHelper.unpocket(title: title, url: url)
                    print("unpocket result: \(result)")
                } else {
                    let result = pocketHelper.pocket(title: title, url: url)
                    print("pocket result: \(result)")

                    let _ = pocketHelper.pockets()
                }

                self.updatePocketBtnIcon()
            }
        }
    }

    @IBAction func index() {
        if let isOpen: Bool = self.webView?.isGitBookIndexOpen() {
            if isOpen {
                let _ = self.webView?.closeGitBookIndex()
            } else {
                let _ = self.webView?.openGitBookIndex()
            }
        } else {
            print("check index open failed!")
        }
    }

    @IBAction func scrollToBottom() {
        let _ = self.webView?.scrollGitBookToBottom()
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
        if let title: String = webView.documentTitle() {
            self.navigationItem.title = self.neatlyTitleFor(elmTitle: title)
        }
        self.updateButtons(force: false, enabled: true)
    }

    // MARK: - private
    func updateButtons(force: Bool, enabled: Bool) -> Void {
        self.indexBtn?.isEnabled = enabled

        if force {
            self.prevBtn?.isEnabled = enabled
            self.nextBtn?.isEnabled = enabled
        } else {
            if let hasPrev = self.webView?.hasGitBookPrevPage() {
                self.prevBtn?.isEnabled = hasPrev
            } else {
                self.prevBtn?.isEnabled = enabled
            }

            if let hasNext = self.webView?.hasGitBookNextPage() {
                self.nextBtn?.isEnabled = hasNext
            } else {
                self.nextBtn?.isEnabled = enabled
            }
        }

        self.pocketBtn?.isEnabled = enabled
        self.shareBtn?.isEnabled = enabled
        self.scrollToBottomBtn?.isEnabled = enabled
    }

    func neatlyTitleFor(elmTitle: String) -> String {
        let elmTitleSuffix = " · An Introduction to Elm"
        if elmTitle.hasSuffix(elmTitleSuffix) {
            let index = elmTitle.index(elmTitle.startIndex, offsetBy: elmTitle.characters.count - elmTitleSuffix.characters.count)
//            let index = elmTitle.startIndex.advancedBy(elmTitle.characters.count - elmTitleSuffix.characters.count)
            return elmTitle.substring(to: index)
        }

        return elmTitle
    }

    func updatePocketBtnIcon() -> Void {
        var faType = FAType.FABookmarkO
        if let url = self.url {
            if pocketHelper.hasPocket(url: url) {
                faType = FAType.FABookmark
            }
        }
        self.pocketBtn?.setFAIcon(icon: faType, iconSize: toolbarIconSize, forState: .normal)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any a dditional setup after loading the view.
        self.updateButtons(force: true, enabled: false)

        self.indexBtn?.setFAIcon(icon: FAType.FAListUl, iconSize: toolbarIconSize, forState: .normal)
        self.prevBtn?.setFAIcon(icon: FAType.FACaretLeft, iconSize: toolbarIconSize, forState: .normal)
        self.nextBtn?.setFAIcon(icon: FAType.FACaretRight, iconSize: toolbarIconSize, forState: .normal)
        self.scrollToBottomBtn?.setFAIcon(icon: FAType.FAHandODown, iconSize: toolbarIconSize, forState: .normal)
        self.updatePocketBtnIcon()

        self.shareBtn?.setFAIcon(icon: FAType.FAShare, iconSize: 18, forState: .normal)
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
