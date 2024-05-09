//
//  ListNotificationsViewController.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import UIKit

final class ListNotificationsViewController: BaseViewController {

    @IBOutlet weak var emptyStackView: UIStackView!
    @IBOutlet weak var notiTableView: UITableView!
    
    private var listNotification = [Notification]()
    
    init(listNoti: [Notification]) {
        self.listNotification = listNoti
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        notiTableView.backgroundColor = .white
        emptyStackView.isHidden = !listNotification.isEmpty
        notiTableView.isHidden = listNotification.isEmpty

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
        return listNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        cell.updateUI(noti: listNotification[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
