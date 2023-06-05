//
//  ShotDataDetailView.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 4.06.2023.
//

import UIKit

class ShotDataDetailView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "ShotDataDetailView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
    
    private func setUI() {
        nameLabel.transform = CGAffineTransform(rotationAngle: (3 * CGFloat.pi) / 2)
    }
    
    func setData(name: String, value: String) {
        self.nameLabel.text = name
        self.valueLabel.text = value
    }
    
}
