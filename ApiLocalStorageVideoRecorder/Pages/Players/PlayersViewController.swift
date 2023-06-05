//
//  PlayersViewController.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import UIKit

class PlayersViewController: UIViewController {
    
    @IBOutlet weak var playersTableView: UITableView!
    private var playersViewModel: PlayersViewModel?
    @IBOutlet weak var playersLabel: UILabel!
    @IBOutlet weak var shotsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        setViewModel()
        fetchPlayers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkPlayerUpdates()
    }
    
    private func setTableView() {
        playersTableView.delegate = self
        playersTableView.dataSource = self
        playersTableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayersCell")
        
    }
    
    private func setViewModel() {
        playersViewModel = PlayersViewModel(coreDataManager: CoreDataManager())
        playersViewModel?.delegate = self
    }
    
    private func fetchPlayers() {
        playersViewModel?.fetchPlayers()
    }
    
    private func checkPlayerUpdates() {
        playersViewModel?.isUpdateNeeded()
    }
    
    private func setUI() {
        self.navigationItem.title = "PLAYER LIST"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}

extension PlayersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersViewModel?.numberOfPlayers() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersCell", for: indexPath) as? PlayersTableViewCell,
              let player = playersViewModel?.getPlayer(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.setCell(with: player)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let player = playersViewModel?.getPlayer(at: indexPath.row) else { return }
        
        if let shotsViewController = UIStoryboard(name: "Shots", bundle: nil).instantiateViewController(withIdentifier: "ShotsViewController") as? ShotsViewController {
            shotsViewController.shotsViewModel = ShotsViewModel()
            shotsViewController.shotsViewModel?.updateShots(player.shots)
            navigationController?.pushViewController(shotsViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension PlayersViewController: PlayersViewModelDelegate {
    func didFetchPlayers() {
        DispatchQueue.main.async {
            self.playersTableView.reloadData()
        }
    }
    
    
}
