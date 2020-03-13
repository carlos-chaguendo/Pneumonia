//
//  CollectionView.swift
//  Pneumonia
//
//  Created by Carlos Chaguendo on 13/03/20.
//  Copyright © 2020 FUP. All rights reserved.
//

import UIKit

extension UICollectionView {

    public func register(withClass cell: UICollectionViewCell.Type) {
        let className = String(describing: cell)
        register(cell, forCellWithReuseIdentifier: className)
    }

    public func register(withClass reusable: UICollectionReusableView.Type, ofKind kind: String) {
        let className = String(describing: reusable)
        register(reusable, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    public func registerNib(withClass cell: UICollectionViewCell.Type) {
        let className = String(describing: cell)
        let bundle = Bundle(for: cell)
        register(UINib(nibName: className, bundle: bundle), forCellWithReuseIdentifier: className)
    }

    public func dequeueReusableCell<Cell: UICollectionViewCell>(withClass name: Cell.Type, for indexPath: IndexPath) -> Cell? {
        let className = String(describing: name)
        return dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? Cell
    }

    public func dequeueReusableView<ReusableView: UICollectionReusableView>(withClass cell: ReusableView.Type,
                                                                              ofKind kind: String,
                                                                              for indexPath: IndexPath) -> ReusableView? {
        let className = String(describing: cell)
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: className, for: indexPath) as? ReusableView

    }

}

extension UICollectionViewController {

    public func dequeue<Cell: UICollectionViewCell>(cell: Cell.Type, for indexPath: IndexPath) -> Cell? {
        return collectionView?.dequeueReusableCell(withClass: cell, for: indexPath)
    }

    public func dequeue<Cell: UICollectionReusableView>(reusableView cell: Cell.Type, ofKind kind: String, for indexPath: IndexPath) -> Cell? {
        return collectionView?.dequeueReusableView(withClass: cell, ofKind: kind, for: indexPath)
    }

}
