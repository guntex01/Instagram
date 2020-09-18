//
//  IGFeedPostTableViewCell.swift
//  Intagram
//
//  Created by guntex01 on 9/17/20.
//  Copyright © 2020 guntex01. All rights reserved.
//

import UIKit

final class IGFeedPostTableViewCell: UITableViewCell {

   
    static let identifier = "IGFeedPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // configure the cell
    }
}
