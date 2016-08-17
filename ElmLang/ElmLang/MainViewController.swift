//
//  ViewController.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/14.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var getStartedButton : UIButton?
    @IBOutlet weak var pocketButton : UIButton?
    @IBOutlet weak var playgroundsButton : UIButton?
    @IBOutlet weak var examplesButton : UIButton?

    @IBOutlet weak var loadingMark : UIActivityIndicatorView?

    var pageList: [String: Page]?
    let pageHelper = PageHelper()
    let appConfigHelper = AppConfigHelper()
    let networkHelper = NetworkHelper()

    var hasAppear: Bool = false

    @IBAction func buttonClicked(sender: UIButton) {
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//        appdelegate.shouldSupportAllOrientation = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {

        let url = self.pageHelper.pageURL(of: segue.identifier!, pageList: self.pageList!)

        if let page = segue.identifier {

            switch page {
            case PageIdentifier.getStarted.rawValue:
                let elmVC = segue.destination as! ElmViewController
                elmVC.url = url
                break
            case PageIdentifier.pocket.rawValue:
                _ = segue.destination as! PocketViewController
                break
            case PageIdentifier.playgrounds.rawValue:
                let replVC = segue.destination as! ReplViewController
                replVC.url = url
                break
            case PageIdentifier.examples.rawValue:
                let replVC = segue.destination as! ReplViewController
                replVC.url = url
                break
            default:
                break
            }
        }
    }

    // MARK: - Rotate
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        buttonsUpdate()
        buttonsEnabled(enabled: false)

        self.networkHelper.fetchAppConfigs() {
            (data, error) -> Void in

            if error != nil {
                print(error)
            } else {
                self.appConfigHelper.parseAppConfigs(data: data)

                if self.appConfigHelper.shutdown {
                    if let shutdownReason = self.appConfigHelper.shutdownReason {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Shutdown", message: shutdownReason, preferredStyle: UIAlertControllerStyle.alert)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    self.networkHelper.fetchURLLocations() {
                        (data, error)->Void in
                        if error != nil {
                            print(error)
                        } else {
                            self.pageList = self.pageHelper.parsePageList(data: data)

                            DispatchQueue.main.async {
                                self.buttonsEnabled(enabled: true)

                                self.loadingMark?.stopAnimating()
                            }
                        }
                    }

                    self.networkHelper.fetchJavascripts() {
                        ( data, error ) -> Void in
                        if error != nil {
                            print(error)
                        } else {
                            JavascriptHelper.sharedInstance.parseJavascripts(data: data)
                        }
                    }
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if hasAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,
                                      forKey: "orientation")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.hasAppear = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - private
    func buttonsUpdate() -> Void {

        let iconSize: CGFloat = 25

        self.getStartedButton?.setFAText(prefixText: "", icon: FAType.FAPlayCircle, postfixText: "  Get Started", size: iconSize, forState: .normal)
        self.pocketButton?.setFAText(prefixText: "", icon: FAType.FABookmarkO, postfixText: "  Pocket", size: iconSize, forState: .normal)
        self.playgroundsButton?.setFAText(prefixText: "", icon: FAType.FATerminal, postfixText: "  Playgrounds", size: iconSize, forState: .normal)
        self.examplesButton?.setFAText(prefixText: "", icon: FAType.FACode, postfixText: "  Examples", size: iconSize, forState: .normal)

        self.getStartedButton?.setFAText(prefixText: "", icon: FAType.FAPlayCircle, postfixText: "  Get Started", size: iconSize, forState: .disabled)
        self.pocketButton?.setFAText(prefixText: "", icon: FAType.FABookmarkO, postfixText: "  Pocket", size: iconSize, forState: .disabled)
        self.playgroundsButton?.setFAText(prefixText: "", icon: FAType.FATerminal, postfixText: "  Playgrounds", size: iconSize, forState: .disabled)
        self.examplesButton?.setFAText(prefixText: "", icon: FAType.FACode, postfixText: "  Examples", size: iconSize, forState: .disabled)
    }

    func buttonsEnabled(enabled: Bool) -> Void {
        self.getStartedButton?.isEnabled = enabled
        self.pocketButton?.isEnabled = enabled
        self.playgroundsButton?.isEnabled = enabled
        self.examplesButton?.isEnabled = enabled
    }
}

extension UINavigationController {
    public override var shouldAutorotate: Bool {
        guard let viewCtrl = self.visibleViewController else { return true }
        return viewCtrl.shouldAutorotate
    }

    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let viewCtrl = self.visibleViewController else { return .all }
        return viewCtrl.supportedInterfaceOrientations
    }

//    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        guard let viewCtrl = self.visibleViewController else { return .portrait }
//        return viewCtrl.preferredInterfaceOrientationForPresentation
//    }
}

