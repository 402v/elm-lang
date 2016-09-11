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

    @IBOutlet weak var editBtn: UIButton?

    let reuseIdentifier = "PennyCell"
    let pocketHelper = PocketHelper()

    var pennyList: [Penny] = PocketHelper().pockets()
    var selectPenny: Penny?

    var hasAppear: Bool = false

    override var editButtonItem: UIBarButtonItem {
        let item = super.editButtonItem
        item.title = "Delete"
        return item
    }

    // MARK: - Actions
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing == false {
            // delete selected items
            self.pennyView?.performBatchUpdates({
                if let selectedIndexPaths = self.pennyView?.indexPathsForSelectedItems {
                    if self.deleteFromDataSource(by: selectedIndexPaths) == true {
                        self.pennyView?.deleteItems(at: selectedIndexPaths)
                    } else {
                        print("delete failed!")
                    }
                }
            }, completion: nil)
        }

        self.pennyView?.allowsMultipleSelection = editing

        super.setEditing(editing, animated: animated)
    }

    func deleteFromDataSource(by indexPaths: [IndexPath]) -> Bool {
        for indexPath in indexPaths {

            if indexPath.row < self.pennyList.count {
                let penny = self.pennyList[indexPath.row]

                if pocketHelper.unpocket(title: penny.title!, url: penny.url!) {
                    self.pennyList.remove(at: indexPath.row)
                }
            }
        }

        let _ = pocketHelper.pockets()
        return true
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Pocket"

        self.navigationItem.rightBarButtonItem = self.editButtonItem

        // Do any additional setup after loading the view.
        if let flowLayout = self.pennyView?.collectionViewLayout as? UICollectionViewFlowLayout {
            // custom size
            if let width = UIApplication.shared.keyWindow?.frame.width {
                flowLayout.itemSize = CGSize(width: width, height: 60)
                flowLayout.invalidateLayout()
            }

            flowLayout.scrollDirection = .vertical

            // separator
            flowLayout.register(PocketSeperatorView.self, forDecorationViewOfKind: "Separator")
            flowLayout.minimumLineSpacing = 1;
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if hasAppear {
            self.pennyList = PocketHelper().pockets()
            self.pennyView?.reloadData()
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

    // MARK: - Segue
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier! {
        case "PocketDetailIdentifier":
            let elmVC = segue.destination as! ElmViewController
            elmVC.url = selectPenny?.url
            break
        default:
            break
        }
    }

    open override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//    open func shouldPerformSegue(withIdentifier identifier: String, sender: AnyObject?) -> Bool {
        return !self.isEditing
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
        cell.titleLable?.text = penny.title
        cell.urlLabel?.text = penny.url?.absoluteString
//        cell.backgroundColor = UIColor.yellow // make cell more visible in our example project
//        cell.layer.borderColor = UIColor.gray.cgColor
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8

        return cell
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.selectPenny = self.pennyList[indexPath.item]
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")

        if isEditing == true {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = UIColor.init(hexString: "eff0f1")

            print("Cell: \(indexPath) as been selected: \(cell?.isSelected)")
        }
    }

    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.init(hexString: "eff0f1")
    }

    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
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

    @IBOutlet weak var titleLable: UILabel?
    @IBOutlet weak var urlLabel: UILabel?
}
