//
//  ListNotificationsViewController.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import UIKit

class ListNotificationsViewController: UIViewController {

    @IBOutlet weak var notiTableView: UITableView!
    
    private var viewModel = NotificationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getListNoti()
    }
   
    @IBAction func onTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

//MARK: - Helper function
extension ListNotificationsViewController {
    private func getListNoti() {
        viewModel.getListNoti { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                DispatchQueue.main.async {
                    self.notiTableView.reloadData()
                }
            }
        }
    }
    private func setupTableView() {
        notiTableView.delegate = self
        notiTableView.dataSource = self
        notiTableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListNotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        cell.updateUI(noti: viewModel.listNotification[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
