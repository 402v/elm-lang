//
//  PocketViewController.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/14.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class PocketViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var pennyView : UICollectionView?

    let reuseIdentifier = "penny_cell"
    var pennyList: [Penny] = PocketHelper().pockets()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    // MARK: - UICollectionViewDataSource
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pennyList.count
    }

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PennyCollectionViewCell

        let penny = self.pennyList[indexPath.item]

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.urlLabel.text = penny.url?.absoluteString
        cell.backgroundColor = UIColor.yellow // make cell more visible in our example project

        return cell
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
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

class PennyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var urlLabel: UILabel!
}
