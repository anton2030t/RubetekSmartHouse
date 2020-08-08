//
//  Intercom.swift
//  RubetekSmartHouse
//
//  Created by Anton Larchenko on 08.08.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import UIKit

final class Intercom: Codable {
    let id: Int
    let intercomId: Int
    let geoUnitId: Int
    let identifier: String
    let notifiedAt: String
    let finishedAt: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
    let pickedupAt: String?
    let snapshot: String
    
    var delegate: DetailViewControllerDelegate?
    
    var image: UIImage? {
        didSet {
            self.delegate?.update(with: image!)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case intercomId = "intercom_id"
        case geoUnitId = "geo_unit_id"
        case identifier = "identifier"
        case notifiedAt = "notified_at"
        case finishedAt = "finished_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case pickedupAt = "pickedup_at"
        case snapshot = "snapshot"
    }
    
}
