//
//  PocketFlowLayout.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/17.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class PocketFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        let layoutAttrs = super.layoutAttributesForElements(in: rect)
        var decorationAttrs = [UICollectionViewLayoutAttributes]()

        let indexPaths: [IndexPath] = self.indexPathsOfSeparators(of: rect)
        for indexPath in indexPaths {
            if let attrs = self.layoutAttributesForDecorationView(ofKind: "Separator", at: indexPath) {
                decorationAttrs.append(attrs)
            }
        }

        if layoutAttrs != nil {
            let retAry = layoutAttrs! + decorationAttrs
            return retAry
        } else {
            return nil
        }
    }

    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        let decorationOffset = CGFloat(indexPath.row + 1) * self.itemSize.height + CGFloat(indexPath.row) * self.minimumLineSpacing

        if let attrs: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, with: indexPath) {
            attrs.frame = CGRect(x: 0, y: decorationOffset, width: self.collectionViewContentSize.width, height: self.minimumLineSpacing)
            attrs.zIndex = 1000

            return attrs
        } else {
            return nil
        }
    }

    override func initialLayoutAttributesForAppearingDecorationElement(ofKind elementKind: String, at decorationIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attrs = self.layoutAttributesForDecorationView(ofKind: elementKind, at: decorationIndexPath) {
            return attrs
        } else {
            return nil
        }
    }

    // MARK: - private
    func indexPathsOfSeparators(of rect: CGRect) -> [IndexPath] {

        let firstCellIndexToShow = Int(rect.origin.y / self.itemSize.height)
        let lastCellIndexToShow = Int((rect.origin.y + rect.height) / self.itemSize.height)

        var indexPaths = [IndexPath]()
        if let collectionView = self.collectionView {
            let count = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)

            for i in stride(from: max(firstCellIndexToShow, 0), to: lastCellIndexToShow, by: 1) {
                if i < count! {
                    indexPaths.append(IndexPath(row: i, section: 0))
                }
            }
        }
        return indexPaths
    }
}
