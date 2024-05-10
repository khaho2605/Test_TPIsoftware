//
//  HomeViewController.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 9/5/24.
//

import UIKit

final class HomeViewController: BaseViewController {
    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var tableView: UITableView!
    
    private var loadingVC = UIViewController()
    private var topCell: TopTableViewCell!
    private var homeViewModel = HomeViewModel()
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
        callAPI(isPullRequest: false)
        setupTableView()
    }

}

//MARK: - Helper
extension HomeViewController {
    private func callAPI(isPullRequest: Bool) {
        self.loadingView.isHidden = false
        notiViewModel.getListNoti(isPullRequest: isPullRequest) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.topCell.updateBadgeNoti(with: self.notiViewModel.listNotification)
            }
        }
        
        homeViewModel.getListFavarite(isPullRequest: isPullRequest) { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                DispatchQueue.main.async {
                    self.reloadTabelView(with: 2)
                }
            }
        }
        
        homeViewModel.getAdBanner(completion: { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                DispatchQueue.main.async {
                    self.reloadTabelView(with: 3)
                }
            }
        })
        
        homeViewModel.getAllAmount(isPullRequest: isPullRequest) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.reloadTabelView(with: 1)
                if isPullRequest {  //Delay to show loading view
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.refreshControl.endRefreshing()
                        self.loadingView.isHidden = true
                    })
                } else {
                    self.loadingView.isHidden = true
                }
            }
        }
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        callAPI(isPullRequest: true)
    }
    
    private func reloadTabelView(with row: Int) {
        let indexPath = IndexPath(item: row, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.showsVerticalScrollIndicator = false

        tableView.register(UINib(nibName: "TopTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTableViewCell")
        tableView.register(UINib(nibName: "BalanceTableViewCell", bundle: nil), forCellReuseIdentifier: "BalanceTableViewCell")
        tableView.register(UINib(nibName: "MyFavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "MyFavoriteTableViewCell")
        tableView.register(UINib(nibName: "AdTableViewCell", bundle: nil), forCellReuseIdentifier: "AdTableViewCell")
        
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
                let notiVC = ListNotificationsViewController(listNoti: notiViewModel.listNotification)
                self.navigationController?.pushViewController(notiVC, animated: true)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceTableViewCell", for: indexPath) as! BalanceTableViewCell
            cell.updateBalance(usd: homeViewModel.usdAmount, khr: homeViewModel.khrAmount)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavoriteTableViewCell", for: indexPath) as! MyFavoriteTableViewCell
            cell.updateUI(with: homeViewModel.favoriteList)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
            cell.updateUI(with: homeViewModel.listAdBanner)
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
