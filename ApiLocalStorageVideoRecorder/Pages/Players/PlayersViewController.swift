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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setViewModel()
        fetchPlayers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkPlayerUpdates()
    }
    
    private func setTableView() {
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
    
    
}

extension PlayersViewController: UITableViewDataSource {
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
    
    
}

extension PlayersViewController: PlayersViewModelDelegate {
    func didFetchPlayers() {
        DispatchQueue.main.async {
            self.playersTableView.reloadData()
        }
    }
    
    
}
