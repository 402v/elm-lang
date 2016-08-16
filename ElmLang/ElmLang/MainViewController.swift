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

    var pageList: [String: Page]?
    let pageHelper = PageHelper()

    var hasAppear: Bool = false

    @IBAction func buttonClicked(sender: UIButton) {
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//        appdelegate.shouldSupportAllOrientation = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        let button = sender as! UIButton
        let title = button.titleLabel?.text
        let url = self.pageHelper.pageURL(title: title, pageList: self.pageList!)

        switch segue.identifier! {
        case "GetStartedIdentifier":
            let elmVC = segue.destination as! ElmViewController
            elmVC.url = url
            break
        case "PocketIdentifier":
            _ = segue.destination as! PocketViewController
            break
        case "PlaygroundsIdentifier":
            let replVC = segue.destination as! ReplViewController
            replVC.url = url
            break
        case "ExamplesIdentifier":
            let replVC = segue.destination as! ReplViewController
            replVC.url = url
            break
        default:
            break
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

        buttonsEnabled(enabled: false)
        
        NetworkHelper().fetchURLLocations() {
            (data, error)->Void in
            if error != nil {
                print(error)
            } else {
                self.pageList = self.pageHelper.parsePageList(data: data)

                DispatchQueue.main.async {
                    self.buttonsEnabled(enabled: true)
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

