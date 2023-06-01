//
//  ShotsTableViewCell.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import UIKit

class ShotsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var inOutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(shot: Shot) {
        pointLabel.text = String(shot.point)
        segmentLabel.text = String(shot.segment)
        inOutLabel.text = String(shot.InOut)
    }
}
