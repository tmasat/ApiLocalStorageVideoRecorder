//
//  ShotsViewController.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import UIKit

class ShotsViewController: UIViewController {
    
    @IBOutlet weak var shotsTableView: UITableView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var inOutLabel: UILabel!
    var shotsViewModel: ShotsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        shotsViewModel?.numberOfShots()
    }
    
    private func setUI() {
        self.navigationItem.title = "SHOT LIST"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    private func setTableView() {
        shotsTableView.delegate = self
        shotsTableView.dataSource = self
        shotsTableView.register(UINib(nibName: "ShotsTableViewCell", bundle: nil), forCellReuseIdentifier: "ShotsCell")
        
    }
}

extension ShotsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shotsViewModel?.numberOfShots() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShotsCell", for: indexPath) as? ShotsTableViewCell,
              let shot = shotsViewModel?.getShot(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.setCell(with: shot, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let shotDetailViewController = UIStoryboard(name: "ShotDetail", bundle: nil).instantiateViewController(withIdentifier: "ShotDetailViewController") as? ShotDetailViewController {
            shotDetailViewController.viewModel = ShotDetailViewModel()
            shotDetailViewController.viewModel?.updateShot((shotsViewModel?.getShot(at: indexPath.row))!)
            navigationController?.pushViewController(shotDetailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
