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

    var pageList : [String: Page]?
    let pageHelper = PageHelper()

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
        return false
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

