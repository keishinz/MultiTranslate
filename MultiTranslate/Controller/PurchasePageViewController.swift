//
//  PurchasePageViewController.swift
//  MultiTranslate
//
//  Created by Keishin CHOU on 2020/02/03.
//  Copyright © 2020 Keishin CHOU. All rights reserved.
//

import UIKit

class PurchasePageViewController: UIViewController {
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "sorasak-_UIN-pFfJ7c-unsplash")
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private let imageViewForegroudView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(white: 0.8, alpha: 0.65)
        
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "close"), for: .normal)
        button.tintColor = .gray
        
        return button
    }()
    
    private let restoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12.5
        button.setTitle("Restore", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        
        return button
    }()
    
    private let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return view
    }()
    
    private let promotionTitle1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Try 14 Days for FREE!"
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textColor = .label
        label.sizeToFit()
        label.numberOfLines = 1
        
        return label
    }()
    
    private let promotionTitle2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "then $24.99 / year"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        label.sizeToFit()
        
        return label
    }()
    
    private let promotionTitle3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "save $10.89 / year"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemPink
        label.sizeToFit()
        
        return label
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        
        return view
    }()
    
    private let subscribeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private let subscribeMonthlyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Subscribe Monthly", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        
        button.sizeToFit()
        button.underline()
        
        return button
    }()
    
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(container)
        container.edgeTo(self.view, safeArea: .all)
        
        container.addSubview(backgroundImageView)
        backgroundImageView.edgeTo(container)
        
        container.addSubview(imageViewForegroudView)
        imageViewForegroudView.edgeTo(container)
        
        container.addSubview(restoreButton)
        restoreButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 25).isActive = true
        restoreButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        restoreButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        restoreButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
//        container.addSubview(closeButton)
//        closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 25).isActive = true
//        closeButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
//        closeButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
//        closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor).isActive = true
        
        container.addSubview(titleView)
        titleView.topAnchor.constraint(equalTo: container.topAnchor, constant: 165).isActive = true
        titleView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 35).isActive = true
        titleView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -35).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        container.addSubview(detailView)
        detailView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20).isActive = true
        detailView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 35).isActive = true
        detailView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -35).isActive = true
        detailView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        container.addSubview(subscribeButton)
        subscribeButton.topAnchor.constraint(equalTo: detailView.bottomAnchor, constant: 30).isActive = true
        subscribeButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        subscribeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        subscribeButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 250).isActive = true
        
        container.addSubview(subscribeMonthlyButton)
        subscribeMonthlyButton.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 10).isActive = true
        subscribeMonthlyButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
     
        titleView.addSubview(promotionTitle1)
        promotionTitle1.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 5).isActive = true
        promotionTitle1.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 5).isActive = true
        
        titleView.addSubview(promotionTitle2)
        promotionTitle2.topAnchor.constraint(equalTo: promotionTitle1.bottomAnchor, constant: 10).isActive = true
        promotionTitle2.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 35).isActive = true
        
        titleView.addSubview(promotionTitle3)
        promotionTitle3.topAnchor.constraint(equalTo: promotionTitle2.bottomAnchor, constant: 8).isActive = true
        promotionTitle3.leadingAnchor.constraint(equalTo: promotionTitle2.leadingAnchor).isActive = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}