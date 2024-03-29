//
//  MainViewController.swift
//  NikeAlbumTest
//
//  Created by YICHUN ZHANG on 1/6/21.
//

import UIKit

protocol MainViewPresenter {
    func onViewLoaded()
}

class MainViewController: UIViewController {
    
    var contentView : UITableView?
    
    var viewModel: MainViewModel?
    
    private var activityIndicator: UIActivityIndicatorView?
    
    var presenter: MainViewPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.onViewLoaded()
        
        setupUI()
    }
    
    private func setupUI()
    {
        
        self.view.backgroundColor = .darkGray
        
        self.title = Configuration.main_title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:.refresh, target: self, action: #selector(action_refresh))
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: activityIndicator)
        activityIndicator.startAnimating()
        
        self.activityIndicator = activityIndicator
        
        viewModel = MainViewModel()
        
        viewModel?.isDataReady.bind(listener: {[weak self] isDataReady in
            
            switch isDataReady
            {
            case .success:
                self?.contentView?.reloadData()
            case .failed:
                let alert = UIAlertController(title: "Cannot access server", message: "Please check your network connection and try again", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self?.present(alert, animated: true)
            case .idle:
                break
            }
            
            self?.activityIndicator?.stopAnimating()
        })
        
        let contentView = UITableView.init(frame: self.view.bounds, style: UITableView.Style.plain)
        self.view.addSubview(contentView)
        contentView.dataSource = self
        contentView.delegate = self
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let contentView_Contrains = [
            contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
       ]
        
        NSLayoutConstraint.activate(contentView_Contrains)
        
        self.contentView = contentView
        
        viewModel?.loadRemoteData(urlStr: Configuration.service_uuid_str)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func action_refresh()
    {
        viewModel?.loadRemoteData(urlStr: Configuration.service_uuid_str)
        
        self.activityIndicator?.startAnimating()
    }

}

extension MainViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getAlbumCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = contentView?.dequeueReusableCell(withIdentifier: "MainTableViewCell")
        
        if cell == nil {
            cell = MainTableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "MainTableViewCell")
        }
        
        cell?.selectionStyle = .none
        
        cell?.textLabel?.text = viewModel?.getName(index: indexPath.row)
        
        cell?.detailTextLabel?.text = viewModel?.getArtist(index: indexPath.row)
            
        cell?.imageView?.image = UIImage(named: "musicholder")
        
        cell?.imageView?.load(urlStr: viewModel?.getIconUrl(index: indexPath.row))
        
        cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
}

extension MainViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        
        vc.setItem(item: viewModel?.getItem(index: indexPath.row))
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
}
