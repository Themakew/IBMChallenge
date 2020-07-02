//
//  EventDetailViewController.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

// MARK: -

class EventDetailViewController: UIViewController {

    // MARK: - Properties -
    
    var id: String
    
    private var eventDetailViewModel = EventDetailViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Init -
    
    init?(coder: NSCoder, id: String) {
        self.id = id
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "EventResponsableTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        
        eventDetailViewModel.getEventDetail(id: id) { [weak self] event in
            do {
                _ = try event.get()
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Internal Methods -
    
    func updateUI() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension EventDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! EventResponsableTableViewCell
        let cellData = eventDetailViewModel.event
        
        cell.userImage.image = UIImage(named: cellData.people?[0].picture ?? "user")
        cell.userName.text = cellData.people?[0].name ?? "-"
        
        return cell
    }
}
