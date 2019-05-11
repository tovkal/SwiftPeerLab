//
//  ExpandableCell.swift
//  AppStoreAnimation
//
//  Created by Andrés Pizá Bückmann on 11/05/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit

class ExpandableCell: UICollectionViewCell {

    private var initialFrame: CGRect?
    private var initialCornerRadius: CGFloat?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true

        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = contentView.layer.cornerRadius
    }

    func expand(in collectionView: UICollectionView) {
        initialFrame = frame
        initialCornerRadius = contentView.layer.cornerRadius

        contentView.layer.cornerRadius = 0
        frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)

        layoutIfNeeded()
    }

    func collapse() {
        contentView.layer.cornerRadius = initialCornerRadius ?? self.contentView.layer.cornerRadius
        frame = initialFrame ?? frame

        initialFrame = nil
        initialCornerRadius = nil

        layoutIfNeeded()
    }

    func hide(in collectionView: UICollectionView, frameOfSelectedCell: CGRect) {
        initialFrame = frame

        let currentY = frame.origin.y
        let newY: CGFloat

        if currentY < frameOfSelectedCell.origin.y {
            let offset = frameOfSelectedCell.origin.y - currentY
            newY = collectionView.contentOffset.y - offset
        } else {
            let offset = currentY - frameOfSelectedCell.maxY
            newY = collectionView.contentOffset.y + collectionView.frame.height + offset
        }

        frame.origin.y = newY
        layoutIfNeeded()
    }

    func show() {
        frame = initialFrame ?? frame
        initialFrame = nil
        layoutIfNeeded()
    }
}
