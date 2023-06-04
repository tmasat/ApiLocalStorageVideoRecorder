//
//  PlayersTableViewCell.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }

    @IBOutlet weak var shotLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    
    @IBOutlet weak var avatarInitialLabel: UILabel!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var shotView: UIView!
    @IBOutlet weak var profileImageView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }
    
    func setCell(with player: Player) {
        nameLabel.text = "\(player.name) \(player.surname)"
        shotLabel.text = String(player.shots.count)
        generateAvatarInitials(name: player.name, surname: player.surname)
    }
    
    private func setCellUI() {
        playerView.layer.cornerRadius = 10
        shotView.layer.cornerRadius = 10
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    private func generateAvatarInitials(name: String, surname: String) {
        avatarInitialLabel.text = "\(name.prefix(1))\(surname.prefix(1))"
    }
    
}
