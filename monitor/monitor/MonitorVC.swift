//
//  ViewController.swift
//  monitor
//
//  Created by Askia Linder on 2018-12-10.
//  Copyright © 2018 Askia Linder. All rights reserved.
//

import UIKit

class MonitorVC: UITableViewController {

    private let viewModel = MonitorVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavbar()
        reload()
    }

    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func reload() {
        viewModel.fetchData { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func setupNavbar() {
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItems = [addBarButtonItem]
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Service Monitor"
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
        if alertController.textFields?[safe: 0]?.text?.isEmpty == false &&
            alertController.textFields?[safe: 1]?.text?.isEmpty == false {
            alertController.actions[safe: 1]?.isEnabled = true
        } else {
            alertController.actions[safe: 1]?.isEnabled = false
        }

        //TODO add check for valid url
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
            textField.placeholder = "URL"
            textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] alertAction in
            guard let name = alertController.textFields?[safe: 0]?.text,
                let url = alertController.textFields?[safe: 1]?.text,
                let URL = URL(string: url),
                let self = self else { return }
            self.viewModel.add(name: name, url: URL)
            self.tableView.reloadData()
        }))
        alertController.actions[safe: 1]?.isEnabled = false
        present(alertController, animated: true)
    }
}

extension MonitorVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        guard let itemForCell = viewModel.items[safe: indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = itemForCell.name
        cell.detailTextLabel?.attributedText = itemForCell.url.absoluteString.toAttributed(color: .gray)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let itemForCell = viewModel.items[safe: indexPath.row] else { return }
            viewModel.delete(id: itemForCell.id)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

