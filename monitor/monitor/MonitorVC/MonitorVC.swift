//
//  ViewController.swift
//  monitor
//
//  Created by Askia Linder on 2018-12-10.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import UIKit

class MonitorVC: UITableViewController {

    private static let timeInterval: TimeInterval = 60
    private let viewModel = MonitorVM()
    private var updateUITimer: Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavbar()
        setupRefreshControl()
        viewModel.refreshDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
        statusCheck()
        setupTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        updateUITimer?.invalidate()
    }

    private func setupTimer() {
        updateUITimer = Timer.scheduledTimer(timeInterval: MonitorVC.timeInterval, target: self, selector: #selector(statusCheck), userInfo: nil, repeats: true)
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(statusCheck), for: .valueChanged)
    }

    private func setupTable() {
        //TODO put 'last-checked-time as table-view-footer' instead of in cell
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MonitorTableCell", bundle: nil), forCellReuseIdentifier: "MonitorTableCell")
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = 50
    }

    @objc private func statusCheck() {
        viewModel.checkServices()
    }

    private func setupNavbar() {
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = addBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Heartbeat"
    }

    // Input validation
    @objc private func textChanged(_ sender: Any) {
        guard let textField = sender as? UITextField else { return }
        var responder = textField as UIResponder

        while !(responder is UIAlertController) {
            guard let next = responder.next else { break }
            responder = next
        }
        guard let alertController = responder as? UIAlertController else { return }

        //check not empty textfields
        guard alertController.textFields?[safe: 0]?.text?.isEmpty == false &&
            alertController.textFields?[safe: 1]?.text?.isEmpty == false
            else {
                alertController.actions[safe: 1]?.isEnabled = false
                return
        }

        alertController.actions[safe: 1]?.isEnabled = true
    }

    @objc func addItem() {
        let alertController = UIAlertController(title: "Add service", message: "Give the service a name and supply it's URL", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField { [weak self] textField in
            guard let self = self else { return }
            textField.placeholder = "Name"
            textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)

        }
        alertController.addTextField { textField in
            textField.placeholder = "Domain name"
            textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] alertAction in
            let protocolSuffix = "http://"
            guard let name = alertController.textFields?[safe: 0]?.text,
                let urlString = alertController.textFields?[safe: 1]?.text,
                let URL = URL(string: protocolSuffix + urlString),
                let self = self else { return }
            self.viewModel.add(name: name, url: URL)
            self.statusCheck()
        }))
        alertController.actions[safe: 1]?.isEnabled = false
        present(alertController, animated: true)
    }
}

extension MonitorVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.services.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonitorTableCell", for: indexPath) as? MonitorTableCell else { return UITableViewCell() }

        guard let model = viewModel.services[safe: indexPath.row] else { return UITableViewCell() }
        let cellVM = MonitorTableCellVM(item: model) { [weak self] in
            let alertController = UIAlertController(title: "URL", message: model.serviceItem.url.absoluteString, preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            self?.present(alertController, animated: true)
        }
        cell.newModel(model: cellVM)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let itemForCell = viewModel.services[safe: indexPath.row] else { return }
            viewModel.delete(id: itemForCell.serviceItem.id)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension MonitorVC: RefreshDelegate {
    func refresh() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
}

