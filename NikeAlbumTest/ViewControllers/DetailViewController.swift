//
//  DetailViewController.swift
//  NikeAlbumTest
//
//  Created by YICHUN ZHANG on 1/6/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageView_icon : UIImageView?
    var label_name : UILabel?
    var label_artistname: UILabel?
    var button_action: UIButton?
    
    var viewModel : DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    

    func setupUI()
    {
        self.view.backgroundColor = UIColor.darkGray
        
        self.title = viewModel?.getName()
        
        let imageView_icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        self.view.addSubview(imageView_icon)
        imageView_icon.load(urlStr:viewModel?.getIconUrl())
        self.imageView_icon = imageView_icon

        imageView_icon.translatesAutoresizingMaskIntoConstraints = false
        let imageView_Contrains = [
            imageView_icon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView_icon.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ]
        
        NSLayoutConstraint.activate(imageView_Contrains)
        
        let label_name = UILabel.init(frame: .zero)
        label_name.text = viewModel?.getName()
        label_name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label_name.textColor = .white
        label_name.sizeToFit()
        self.view.addSubview(label_name)
        self.label_name = label_name
        
        label_name.translatesAutoresizingMaskIntoConstraints = false
        let label_name_Contrains = [
            label_name.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label_name.topAnchor.constraint(equalTo: imageView_icon.bottomAnchor, constant: 10),
        ]

        NSLayoutConstraint.activate(label_name_Contrains)
        
        let label_artistname = UILabel.init(frame: .zero)
        label_artistname.text = "Artist: \(viewModel?.getArtist() ?? "N/A")"
        label_artistname.font = UIFont.systemFont(ofSize: 18)
        label_artistname.textColor = .white
        label_artistname.sizeToFit()
        self.view.addSubview(label_artistname)
        self.label_artistname = label_artistname
        
        label_artistname.translatesAutoresizingMaskIntoConstraints = false
        let label_artistname_Contrains = [
            label_artistname.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label_artistname.topAnchor.constraint(equalTo: label_name.bottomAnchor, constant: 10),
        ]

        NSLayoutConstraint.activate(label_artistname_Contrains)
        
        let button_action = UIButton(type: .custom)
        button_action.backgroundColor = .white
        button_action.setTitle("Go to iTunes", for: .normal)
        button_action.setTitleColor(.red, for: .normal)
        button_action.sizeToFit()
        button_action.addTarget(self, action: #selector(action_itunes), for: .touchUpInside)
        self.view.addSubview(button_action)
        
        button_action.translatesAutoresizingMaskIntoConstraints = false
        let button_action_Contrains = [
            NSLayoutConstraint(item: button_action,
                               attribute: .leading,
                                                      relatedBy: .equal,
                                                      toItem: self.view,
                                                      attribute: .leading,
                                                      multiplier: 1.0,
                                                      constant: 20.0),
            NSLayoutConstraint(item: button_action,
                               attribute: .trailing,
                                                      relatedBy: .equal,
                                                      toItem: self.view,
                                                      attribute: .trailing,
                                                      multiplier: 1.0,
                                                      constant: -20.0),
            button_action.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(button_action_Contrains)
    }
    
    @objc func action_itunes()
    {
        if let urlStr = viewModel?.getITuneUrl() {
            if let url = URL(string: urlStr) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func setItem(item : MusicItem?)
    {
        viewModel = DetailViewModel()
        viewModel?.item = item
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
