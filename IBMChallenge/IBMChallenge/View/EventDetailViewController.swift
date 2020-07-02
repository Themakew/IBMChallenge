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
    
    private var eventList: [CellLineModel] = []
    
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
        tableView.register(UINib(nibName: "MapLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "mapCell")
        tableView.register(UINib(nibName: "GenericTwoColumnTableViewCell", bundle: nil), forCellReuseIdentifier: "genericCell")
        
        eventDetailViewModel.getEventDetail(id: id) { [weak self] event in
            do {
                _ = try event.get()
                DispatchQueue.main.async {
                    self?.getEventList()
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
    
    // MARK: - Private Methods -
    
    private func getEventList() {
        eventList = eventDetailViewModel.buildEventList(eventList: eventList)
    }
}


// MARK: - Extension -

extension EventDetailViewController {
    @IBAction
    func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension EventDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellData = eventList[indexPath.row]
        
        if let mapCell = cellData as? MapLine {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as! MapLocationTableViewCell

            cell.setLocation(
                latitude: mapCell.latitude,
                longitude: mapCell.longitude
            )

            return cell
        } else if let userCell = cellData as? InfoLine {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! EventResponsableTableViewCell
            
            cell.bind(
                titleLbl: userCell.title,
                imageName: userCell.imageName,
                userName: userCell.description
            )
            
            cell.isUserInteractionEnabled = false
            
            return cell
        } else {
            if let genericCell = cellData as? TwoColumnInfoLine {
                let cell = tableView.dequeueReusableCell(withIdentifier: "genericCell", for: indexPath) as! GenericTwoColumnTableViewCell
                
                cell.bind(
                    titleText: genericCell.title,
                    descriptionText: genericCell.description
                )
                
                cell.isUserInteractionEnabled = false
                
                return cell
            } else {
                let cell = UITableViewCell()
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
