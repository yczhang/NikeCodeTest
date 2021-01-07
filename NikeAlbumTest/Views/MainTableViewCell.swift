//
//  MainTableViewCell.swift
//  NikeAlbumTest
//
//  Created by YICHUN ZHANG on 1/7/21.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if let imageView = self.imageView {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let imageView_Contrains = [
            NSLayoutConstraint(item: imageView,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 5.0),
            NSLayoutConstraint(item: imageView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: 5.0),
            
            NSLayoutConstraint(item: imageView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: -5.0),
            
            NSLayoutConstraint(item: imageView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: imageView,
                               attribute: .height,
                               multiplier: 1.0,
                               constant: 0),
            ]
            NSLayoutConstraint.activate(imageView_Contrains)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
