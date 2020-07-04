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

    @IBOutlet weak var tableView: UITableView!
    
    var id: String
    
    private var eventDetailViewModel = EventDetailViewModel()
    private var eventList: [CellLineModel] = []
    
    // MARK: - Init -
    
    init?(coder: NSCoder, id: String) {
        self.id = id
        super.init(coder: coder)
    }
    
    // MARK: - View Lifecycle -
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "EventResponsableTableViewCell", bundle: nil), forCellReuseIdentifier: EventResponsableTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: "MapLocationTableViewCell", bundle: nil), forCellReuseIdentifier: MapLocationTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: "GenericTwoColumnTableViewCell", bundle: nil), forCellReuseIdentifier: GenericTwoColumnTableViewCell.cellIdentifier)
        
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
    
    @IBAction
    func checkInAction(_ sender: Any) {
        Utils.setTextFieldAlert(viewController: self) { (nameText, emailText) in
            if let name = nameText, let email = emailText {
                self.eventDetailViewModel.sendUserDetail(request: UserDetail(eventId: self.eventDetailViewModel.event.id ?? "", name: name, email: email)) { (error) in
                    if error == nil {
//                        if email.isValidEmail() {
                            Utils.alert(self, "service_success".text())
//                        } else {
//                            Utils.alert(self, "alert_email_error".text())
//                        }
                    } else {
                        Utils.alert(self, error?.localizedDescription ?? "service_error".text())
                    }
                }
            } else {
                Utils.alert(self, "alert_empty_fields".text())
            }
        }
    }

    @IBAction
    func shareAction(_ sender: Any) {
        guard let image = Utils.getImageFromDevice(imageName: eventDetailViewModel.event.id ?? "", storageType: .fileSystem) else { return }
        let title = "event".text(comment: "", suffix: ": ") + (eventDetailViewModel.event.title ?? "")
        let description = "description".text(comment: "", suffix: ": ") + (eventDetailViewModel.event.description ?? "")
            
        Utils.shareInformation(viewController: self, title: title, description: description, image: image)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: MapLocationTableViewCell.cellIdentifier, for: indexPath) as! MapLocationTableViewCell

            cell.setLocation(
                latitude: mapCell.latitude,
                longitude: mapCell.longitude
            )

            return cell
        } else if let userCell = cellData as? InfoLine {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventResponsableTableViewCell.cellIdentifier, for: indexPath) as! EventResponsableTableViewCell
            
            cell.bind(
                titleLbl: userCell.title,
                imageName: userCell.imageName,
                userName: userCell.description
            )
            
            cell.isUserInteractionEnabled = false
            
            return cell
        } else {
            if let genericCell = cellData as? TwoColumnInfoLine {
                let cell = tableView.dequeueReusableCell(withIdentifier: GenericTwoColumnTableViewCell.cellIdentifier, for: indexPath) as! GenericTwoColumnTableViewCell
                
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
