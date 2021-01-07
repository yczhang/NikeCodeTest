//
//  MainViewController.swift
//  NikeAlbumTest
//
//  Created by YICHUN ZHANG on 1/6/21.
//

import UIKit

class MainViewController: UIViewController {
    
    private var contentView : UITableView?
    
    private var viewModel: MainViewModel?
    
    private var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI()
    {
        
        self.view.backgroundColor = .darkGray
        
        self.title = "Nike Music Album"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:.refresh, target: self, action: #selector(action_refresh))
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: activityIndicator)
        activityIndicator.startAnimating()
        
        self.activityIndicator = activityIndicator
        
        viewModel = MainViewModel()
        
        viewModel?.isDataReady.bind(listener: {[weak self] isDataReady in
            
            if isDataReady {
                
                self?.contentView?.reloadData()
            }
            else
            {
                let alert = UIAlertController(title: "Cannot access server", message: "Please check your network connection and try again", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self?.present(alert, animated: true)
            }
            
            self?.activityIndicator?.stopAnimating()
        })
        
        contentView = UITableView.init(frame: self.view.bounds, style: UITableView.Style.plain)
        
        if let subview = contentView {
            
            self.view.addSubview(subview)
            
        }
                
        contentView?.dataSource = self
        contentView?.delegate = self
        
//        viewModel?.loadLocalData()
        
        viewModel?.loadRemoteData()
    }
    
    @objc func action_refresh()
    {
        viewModel?.loadRemoteData()
        
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
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "MainTableViewCell")
        }
        
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
