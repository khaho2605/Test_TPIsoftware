//
//  HomeViewController.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 7/5/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    private var topCell: TopTableViewCell!
    private var balanceCell: BalanceTableViewCell!

    private var viewModel = HomeViewModel()
    private var notiViewModel = NotificationViewModel()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(handleRefresh(_:)),
                                 for: .valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAPI()
        setupTableView()
    }

}

//MARK: - Helper
extension HomeViewController {
    private func callAPI() {
        viewModel.getAdBanner(completion: { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                DispatchQueue.main.async {
                    self.reloadTabelView(with: 3)
                }
            }
        })
        
        viewModel.getAllAmount { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.reloadTabelView(with: 1)
            }
        }
    }
    
    private func reloadTabelView(with row: Int) {
        let indexPath = IndexPath(item: row, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.register(UINib(nibName: "TopTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTableViewCell")
        tableView.register(UINib(nibName: "BalanceTableViewCell", bundle: nil), forCellReuseIdentifier: "BalanceTableViewCell")
        tableView.register(UINib(nibName: "MyFavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "MyFavoriteTableViewCell")
        tableView.register(UINib(nibName: "AdTableViewCell", bundle: nil), forCellReuseIdentifier: "AdTableViewCell")        
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        notiViewModel.getListNoti { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                DispatchQueue.main.async {
                    self.topCell.updateBadgeNoti()
                }
            }
        }
        
        viewModel.getListFavarite { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                DispatchQueue.main.async {
                    self.reloadTabelView(with: 2)
                }
            }
        }
        
        viewModel.getAllAmount { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.reloadTabelView(with: 1)
                refreshControl.endRefreshing()
            }
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCell", for: indexPath) as! TopTableViewCell
            topCell = cell
            cell.onTapNotiButton = { [weak self] in
                guard let self = self else { return }
                let notiVC = ListNotificationsViewController()
                self.navigationController?.pushViewController(notiVC, animated: true)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceTableViewCell", for: indexPath) as! BalanceTableViewCell
            cell.updateBalance(usd: viewModel.usdAmount, khr: viewModel.khrAmount)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavoriteTableViewCell", for: indexPath) as! MyFavoriteTableViewCell
            cell.updateUI(with: viewModel.favoriteList)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
            cell.updateUI(with: viewModel.listAdBanner)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 60
        case 1:
            return 370
        case 2:
            return 160
        case 3:
            return 130
        default: return 0
        }
    }
    
}
