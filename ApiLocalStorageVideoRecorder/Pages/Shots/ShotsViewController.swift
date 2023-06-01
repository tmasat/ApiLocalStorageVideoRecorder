//
//  ShotsViewController.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import UIKit

class ShotsViewController: UIViewController {
    
    @IBOutlet weak var shotsTableView: UITableView!
    var shotsViewModel: ShotsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        shotsViewModel?.numberOfShots()
    }
    
    private func setTableView() {
        shotsTableView.dataSource = self
        shotsTableView.register(UINib(nibName: "ShotsTableViewCell", bundle: nil), forCellReuseIdentifier: "ShotsCell")
        
    }
}

extension ShotsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shotsViewModel?.numberOfShots() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShotsCell", for: indexPath) as? ShotsTableViewCell,
              let shot = shotsViewModel?.getShot(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.setCell(shot: shot)
        return cell
    }
}
