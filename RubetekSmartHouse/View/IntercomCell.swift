//
//  IntercomCell.swift
//  RubetekSmartHouse
//
//  Created by Anton Larchenko on 08.08.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import UIKit

class IntercomCell: UITableViewCell {
    
    var task: URLSessionDataTask?

    @IBOutlet weak var callIconImageView: UIImageView!
    @IBOutlet weak var intercomLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationUnitLabel: UILabel!
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    static let identifier = "IntercomCell"
    
    internal var aspectConstraint: NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                screenshotImageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                screenshotImageView.addConstraint(aspectConstraint!)
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
        screenshotImageView.image = nil
        isHidden = false
        isSelected = false
        isHighlighted = false
        task?.cancel()
    }
    
    func setScreenshotImage(image : UIImage) {

        let aspect = image.size.width / image.size.height

        let constraint = NSLayoutConstraint(item: screenshotImageView as Any, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: screenshotImageView, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 100.0)
        constraint.priority = UILayoutPriority(rawValue: 999)

        aspectConstraint = constraint

        screenshotImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        screenshotImageView.layer.cornerRadius = screenshotImageView.frame.size.height/10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
