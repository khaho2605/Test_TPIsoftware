//
//  ListNotificationsViewController.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import UIKit

class ListNotificationsViewController: UIViewController {

    @IBOutlet weak var notiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
   
    @IBAction func onTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

//MARK: - Helper function
extension ListNotificationsViewController {
    private func setupTableView() {
        notiTableView.delegate = self
        notiTableView.dataSource = self
        notiTableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListNotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
