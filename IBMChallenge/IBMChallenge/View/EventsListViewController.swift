//
//  EventsListViewController.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

class EventsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var data = [EventModel]()
    var eventsListViewModel = EventsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        showActivity()
        eventsListViewModel.getEvents { [weak self] events in
            do {
                _ = try events.get()
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.backgroundView = nil
                    self?.updateUI()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func showActivity() {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator.style = .medium
        activityIndicator.startAnimating()
        
        tableView.backgroundView = activityIndicator
    }
    
    func updateUI() {
        tableView.reloadData()
    }
}

extension EventsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsListViewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventTableViewCell
        let cellData = eventsListViewModel.events[indexPath.row]
        
        cell.labelOne.text = cellData.title
        cell.labelTwo.text = cellData.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "send", sender: self)
    }
}
