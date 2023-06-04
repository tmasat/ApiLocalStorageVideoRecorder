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
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var shotNumberLabel: UILabel!
    
    @IBOutlet weak var inOutView: UIView!
    @IBOutlet weak var pointView: UIView!
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pointView.layer.borderWidth = 1
        pointView.layer.borderColor = UIColor.darkGray.cgColor
        
        scoreView.layer.cornerRadius = 10
        scoreView.layer.borderWidth = 2
        scoreView.layer.borderColor = UIColor.darkGray.cgColor
        
        inOutView.layer.cornerRadius = 10
        inOutView.layer.borderWidth = 2
        inOutView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func setCell(with shot: Shot, index: Int) {
        shotNumberLabel.text = "\(String(index + 1))."
        pointLabel.text = String(shot.point)
        segmentLabel.text = String(shot.segment)
        checkInOutText(with: shot.InOut)
    }
    
    private func checkInOutText(with inOut: Bool) {
        guard inOut else {
            inOutLabel.text = "OUT"
            inOutLabel.textColor = UIColor.red
            return
        }
        
        inOutLabel.text = "IN"
        inOutLabel.textColor = UIColor.green
        
    }
}
