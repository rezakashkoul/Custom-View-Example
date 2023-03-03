//
//  MainViewController.swift
//  mySampleTest
//
//  Created by Reza Kashkoul on 12/12/1401.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var objects: [CustomView.Config] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        applyMockData()
        setupViews()
    }

}

//MARK: - Setup Views
extension MainViewController {
    
    private func setupViews() {
        navigationBar()
        setupTableView()
    }
    
    private func navigationBar() {
        title = "Welcome!"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: TableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: TableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - Setup TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.setup(objects[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {[self] in
            let vc = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            let items = objects[indexPath.row].items
            vc.config = MenuViewController.Config(items: items, selectedIndex: { [self] childIndex in
                cellSelectionAction(parentIndex: indexPath.row, childIndex: childIndex)
            })
            navigationController?.present(vc, animated: true)
        }
    }
}

//MARK: - Setup Actions
extension MainViewController {

    func cellSelectionAction(parentIndex: Int, childIndex: Int) {
        let items = objects[parentIndex].items
        objects[parentIndex].title = items[childIndex]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - Create Mock Data
extension MainViewController {
    
    private func applyMockData() {
        objects.append(CustomView.Config(header: "Alphabet", title: "A", items: ["A","B","C","D","E","f"]))
        objects.append(CustomView.Config(header: "Numbers", title: "1", items: ["1","2","3","4","5","6"]))
        objects.append(CustomView.Config(header: "Gender", title: "male", items: ["male", "female"]))
    }
}
