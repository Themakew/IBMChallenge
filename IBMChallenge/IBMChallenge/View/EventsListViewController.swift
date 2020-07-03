//
//  EventsListViewController.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

// MARK: -

class EventsListViewController: UIViewController {
    
    // MARK: - Properties -
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var data = [EventModel]()
    private var eventsListViewModel = EventsListViewModel()
    
    // MARK: - View Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        showActivity()
        eventsListViewModel.getEvents { [weak self] events in
            do {
                _ = try events.get()
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.backgroundView = nil
                    self?.updateUI()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Internal Methods -
    
    func showActivity() {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator.style = .medium
        activityIndicator.startAnimating()
        
        tableView.backgroundView = activityIndicator
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    @IBSegueAction
    func sendEventData(_ coder: NSCoder) -> EventDetailViewController? {
        guard let row = tableView.indexPathForSelectedRow?.row else { return nil }
        return EventDetailViewController(coder: coder, id: String(row + 1))
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension EventsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsListViewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.cellIdentifier, for: indexPath) as! EventTableViewCell
        let cellData = eventsListViewModel.events[indexPath.row]
        
        cell.titleLbl.text = cellData.title
        cell.descriptionLbl.text = cellData.formattedDescription
        cell.getLocation(latitude: cellData.latitude ?? 0.0, longitude: cellData.longitude ?? 0.0)
        cell.dateLbl.text = cellData.formattedDate
        cell.priceLbl.text = cellData.formattedPrice
        
        if let url = URL(string: cellData.image ?? ""), let id = cellData.id {
            cell.getImageFromURL(imageId: id, url: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sendData", sender: self)
    }
}
