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
    var label_release_date: UILabel?
    var label_copyright: UILabel?
    var label_genres: UILabel?
    var button_action: UIButton?
    
    var view_info: UIView?
    
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
                
        let view_info = UIView.init(frame: .zero)
//        view_info.clipsToBounds = true
        self.view.addSubview(view_info)
        self.view_info = view_info
        
        view_info.backgroundColor = .red
        
        let name_str = "Name: \(viewModel?.getName() ?? "N/A")"
        let label_name_h = name_str.height(constraintedWidth: 200, font: UIFont.systemFont(ofSize: 18, weight: .bold))
        
        let label_name = UILabel.init(frame: CGRect(x: 0, y: 0, width: 200, height: label_name_h))
        label_name.text = "Name: \(viewModel?.getName() ?? "N/A")"
        label_name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label_name.textColor = .white
        label_name.numberOfLines = 0
        label_name.lineBreakMode = .byWordWrapping
        label_name.sizeToFit()
        view_info.addSubview(label_name)
        self.label_name = label_name
        
        label_name.translatesAutoresizingMaskIntoConstraints = false
        let label_name_Contrains = [
            label_name.leadingAnchor.constraint(equalTo: view_info.leadingAnchor, constant: 0),
            label_name.trailingAnchor.constraint(equalTo: view_info.trailingAnchor, constant: 0),
            label_name.topAnchor.constraint(equalTo: view_info.topAnchor, constant: 0),
        ]

        NSLayoutConstraint.activate(label_name_Contrains)
        
        let label_artistname = UILabel.init(frame: .zero)
        label_artistname.text = "Artist: \(viewModel?.getArtist() ?? "N/A")"
        label_artistname.font = UIFont.systemFont(ofSize: 18)
        label_artistname.textColor = .white
        label_artistname.sizeToFit()
        view_info.addSubview(label_artistname)
        self.label_artistname = label_artistname
        
        label_artistname.translatesAutoresizingMaskIntoConstraints = false
        let label_artistname_Contrains = [
            label_artistname.leadingAnchor.constraint(equalTo: label_name.leadingAnchor),
            label_artistname.trailingAnchor.constraint(equalTo: label_artistname.trailingAnchor, constant: 0),
            label_artistname.topAnchor.constraint(equalTo: label_name.bottomAnchor, constant: 10),
        ]

        NSLayoutConstraint.activate(label_artistname_Contrains)
        
        let label_release_date = UILabel.init(frame: .zero)
        label_release_date.text = "Release Date: \(viewModel?.getReleaseDate() ?? "N/A")"
        label_release_date.font = UIFont.systemFont(ofSize: 18)
        label_release_date.textColor = .white
        label_release_date.sizeToFit()
        view_info.addSubview(label_release_date)
        self.label_release_date = label_release_date
        
        label_release_date.translatesAutoresizingMaskIntoConstraints = false
        let label_release_date_Contrains = [
            label_release_date.leadingAnchor.constraint(equalTo: label_name.leadingAnchor),
            label_release_date.topAnchor.constraint(equalTo: label_artistname.bottomAnchor, constant: 10),
        ]

        NSLayoutConstraint.activate(label_release_date_Contrains)
    
        let copyright_str = "Copyright: \(viewModel?.getCopyRight() ?? "N/A")"
        let label_copyright_h = copyright_str.height(constraintedWidth: 200, font: UIFont.systemFont(ofSize: 18))
        let label_copyright = UILabel.init(frame: CGRect(x: 0, y: 0, width: 200, height: label_copyright_h))
        label_copyright.text = copyright_str
        label_copyright.font = UIFont.systemFont(ofSize: 18)
        label_copyright.textColor = .white
        label_copyright.numberOfLines = 0
        label_copyright.lineBreakMode = .byWordWrapping
//        label_copyright.sizeToFit()
        view_info.addSubview(label_copyright)
        self.label_copyright = label_copyright
        
        label_copyright.translatesAutoresizingMaskIntoConstraints = false
        let label_copyright_Contrains = [
            label_copyright.leadingAnchor.constraint(equalTo: label_name.leadingAnchor),
            label_copyright.trailingAnchor.constraint(equalTo: label_name.trailingAnchor),
            label_copyright.topAnchor.constraint(equalTo: label_release_date.bottomAnchor, constant: 10),
        ]

        NSLayoutConstraint.activate(label_copyright_Contrains)
        
        let label_genres = UILabel.init(frame: .zero)
        label_genres.text = "Genres: \(viewModel?.getGenres() ?? "N/A")"
        label_genres.font = UIFont.systemFont(ofSize: 18)
        label_genres.textColor = .white
        label_genres.sizeToFit()
        view_info.addSubview(label_genres)
        self.label_genres = label_genres
        
        label_genres.translatesAutoresizingMaskIntoConstraints = false
        let label_genres_Contrains = [
            label_genres.leadingAnchor.constraint(equalTo: label_name.leadingAnchor),
            label_genres.topAnchor.constraint(equalTo: label_copyright.bottomAnchor, constant: 10),
        ]

        NSLayoutConstraint.activate(label_genres_Contrains)
        
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
        
        if UIApplication.shared.statusBarOrientation.isLandscape {
             applyLandscapeLayout()
        } else {
             applyPortrainLayout()
        }
    }
/*    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIApplication.shared.statusBarOrientation.isLandscape {
             applyLandscapeLayout()
        } else {
             applyPortrainLayout()
        }
    }*/
    override func viewWillTransition(to size: CGSize, with coordinator:    UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in

            let orient = UIApplication.shared.statusBarOrientation
            switch orient {
            case .portrait:
                print("Portrait")
                self.applyPortrainLayout()
                break
                // Do something
            default:
                print("LandScape")
                // Do something else
                self.applyLandscapeLayout()
                break
            }
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                print("rotation completed")
        })
        
        super.viewWillTransition(to: size, with: coordinator)

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

    private var customConstraints = [NSLayoutConstraint]()

    private func activate(constraints: [NSLayoutConstraint]) {
        customConstraints.append(contentsOf: constraints)
        customConstraints.forEach { $0.isActive = true }
    }

    private func clearConstraints() {
        customConstraints.forEach { $0.isActive = false }
        customConstraints.removeAll()
    }

    func applyPortrainLayout()
    {
        clearConstraints()
        
        guard let imageView_icon = self.imageView_icon else {
            return
        }
        imageView_icon.translatesAutoresizingMaskIntoConstraints = false
                        
        let imageView_Contrains = [
            imageView_icon.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imageView_icon.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ]
        
        NSLayoutConstraint.activate(imageView_Contrains)
        
        guard let view_info = self.view_info else {
            return
        }
        
        view_info.translatesAutoresizingMaskIntoConstraints = false
    
        let view_info_Contrains = [
            view_info.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view_info.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            view_info.topAnchor.constraint(equalTo: imageView_icon.bottomAnchor, constant: 10),
        ]

        NSLayoutConstraint.activate(view_info_Contrains)
        activate(constraints: imageView_Contrains)
        activate(constraints: view_info_Contrains)
    }
    
    func applyLandscapeLayout()
    {
        clearConstraints()
        
        guard let imageView_icon = self.imageView_icon else {
            return
        }
        imageView_icon.translatesAutoresizingMaskIntoConstraints = false

        let imageView_Contrains = [
            imageView_icon.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            imageView_icon.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView_icon.widthAnchor.constraint(equalTo: imageView_icon.heightAnchor, multiplier: 1)
        ]
        
        NSLayoutConstraint.activate(imageView_Contrains)
        
        guard let view_info = self.view_info else {
            return
        }
        view_info.translatesAutoresizingMaskIntoConstraints = false
        
        let view_info_Contrains = [
            view_info.leadingAnchor.constraint(equalTo: imageView_icon.trailingAnchor, constant: 10),
            view_info.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            view_info.topAnchor.constraint(equalTo: imageView_icon.topAnchor, constant: 0),
        ]

        NSLayoutConstraint.activate(view_info_Contrains)
        
        activate(constraints: imageView_Contrains)
        activate(constraints: view_info_Contrains)
    }
}

extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }
}
