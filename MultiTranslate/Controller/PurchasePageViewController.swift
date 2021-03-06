//
//  PurchasePageViewController.swift
//  MultiTranslate
//
//  Created by Keishin CHOU on 2020/02/03.
//  Copyright © 2020 Keishin CHOU. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit
import SPAlert

class PurchasePageViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .darkGray
        
        return button
    }()
    
    private let restoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 12.5
        button.setTitle("Restore".localized(), for: .normal)
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
        label.text = "Try 14 Days for FREE!".localized()
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textColor = .black
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .natural
        
        return label
    }()
    
    private let promotionTitle2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "then %@ / year".localizedFormat(InAppPurchaseManager.retrievedProducts[0].localizedPrice!)
        //↑ localize variable strings https://stackoverflow.com/questions/26277626/nslocalizedstring-with-swift-variable
        //↑ https://stackoverflow.com/questions/35316655/how-to-format-localised-strings-in-swift
        //↑ https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
        
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.sizeToFit()
        
        return label
    }()
    
    private let promotionTitle3: UILabel = {
        let label = UILabel()
        let monthlyPrice = Double(truncating: InAppPurchaseManager.retrievedProducts[1].price)
        let yearlyPrice = Double(truncating: InAppPurchaseManager.retrievedProducts[0].price)
        let savedPrice = monthlyPrice * 12 - yearlyPrice as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "save %@ / year".localizedFormat(formatter.string(from: savedPrice)!)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemPink
        label.sizeToFit()
        
        return label
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .blue
        
        return view
    }()
    
    private let detailCameraView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .gray
        
        return view
    }()
    
    private let detailVioceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .gray
        
        return view
    }()
    
    private let detailConversationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .gray
        
        return view
    }()
    
    private let detailObjectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .gray
        
        return view
    }()
    
    private let detailDocumnetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .gray
        
        return view
    }()
    
    private let detailCameraImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "camera")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        
        return view
    }()
    
    private let detailCameraDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Detect words in photos and translate.".localized()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let detailVoiceImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "microphone")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        
        return view
    }()
    
    private let detailVoiceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Detect words in speech and translate.".localized()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let detailConversationImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "conversation")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        
        return view
    }()
    
    private let detailConversationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Translate conversation smoothly.".localized()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let detailObjectImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "AR")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        
        return view
    }()
    
    private let detailObjectDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Detect objects in reality and translate.".localized()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let detailDocumentImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "pdf")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        
        return view
    }()
    
    private let detailDocumentDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Scan document and detect words in document.".localized()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let subscribeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START".localized(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .bold)
//        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private let subscribeMonthlyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Subscribe Monthly".localized(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.backgroundColor = .clear
        button.underline()
        
        return button
    }()
    
    private let statementView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let subscriptionInformationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private let termsOfUseInformationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let privacyPolicyInformationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let subscriptionInformationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("About subscription".localized(), for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .normal)
        button.setTitleColor(.systemGray5, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private let termsOfUseInformationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Terms of use".localized(), for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .normal)
        button.setTitleColor(.systemGray5, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private let privacyPolicyInformationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Privacy policy".localized(), for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .normal)
        button.setTitleColor(.systemGray5, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(scrollView)
        scrollView.edgeTo(view, safeArea: .top)
        
        scrollView.addSubview(container)
        container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let containerHeightConstraint = container.heightAnchor.constraint(equalTo: view.heightAnchor)
        containerHeightConstraint.isActive = true
        containerHeightConstraint.priority = UILayoutPriority(rawValue: 250)
        
        
        container.addSubview(backgroundImageView)
        backgroundImageView.edgeTo(view)
        
        container.addSubview(imageViewForegroudView)
        imageViewForegroudView.edgeTo(view)
        
        container.addSubview(restoreButton)
        restoreButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 25).isActive = true
        restoreButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        restoreButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        restoreButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        container.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 25).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor).isActive = true
        
        container.addSubview(titleView)
        titleView.topAnchor.constraint(equalTo: container.topAnchor, constant: 165).isActive = true
        titleView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        container.addSubview(detailView)
        detailView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 5).isActive = true
        detailView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 35).isActive = true
        detailView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        detailView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        container.addSubview(subscribeButton)
        subscribeButton.topAnchor.constraint(equalTo: detailView.bottomAnchor, constant: 30).isActive = true
        subscribeButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        subscribeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        subscribeButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 250).isActive = true
        subscribeButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 35).isActive = true
        subscribeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -35).isActive = true
        
        container.addSubview(subscribeMonthlyButton)
        subscribeMonthlyButton.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 10).isActive = true
        subscribeMonthlyButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        container.addSubview(statementView)
        statementView.topAnchor.constraint(equalTo: subscribeMonthlyButton.bottomAnchor, constant: 30).isActive = true
        statementView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        statementView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
//        statementView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        statementView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        statementView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -30).isActive = true
     
        titleView.addSubview(promotionTitle1)
        promotionTitle1.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 5).isActive = true
        promotionTitle1.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 35).isActive = true
        promotionTitle1.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -5).isActive = true
        
        titleView.addSubview(promotionTitle2)
        promotionTitle2.topAnchor.constraint(equalTo: promotionTitle1.bottomAnchor, constant: 10).isActive = true
        promotionTitle2.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 35).isActive = true
        
        titleView.addSubview(promotionTitle3)
        promotionTitle3.topAnchor.constraint(equalTo: promotionTitle2.bottomAnchor, constant: 8).isActive = true
        promotionTitle3.leadingAnchor.constraint(equalTo: promotionTitle2.leadingAnchor).isActive = true
        
        detailView.VStack(detailCameraView,
                          detailVioceView,
                          detailConversationView,
                          detailObjectView,
                          detailDocumnetView,
                          spacing: 2,
                          alignment: .fill,
                          distribution: .fillEqually)
        
        detailCameraView.hstack(detailCameraImageView.setWidth(35),
                                detailCameraDescriptionLabel,
                                spacing: 5,
                                alignment: .fill,
                                distribution: .fill)
        
        detailVioceView.hstack(detailVoiceImageView.setWidth(35),
                               detailVoiceDescriptionLabel,
                               spacing: 5,
                               alignment: .fill,
                               distribution: .fill)
        
        detailConversationView.hstack(detailConversationImageView.setWidth(35),
                                      detailConversationDescriptionLabel,
                                      spacing: 5,
                                      alignment: .fill,
                                      distribution: .fill)
        
        detailObjectView.hstack(detailObjectImageView.setWidth(35),
                                detailObjectDescriptionLabel,
                                spacing: 5,
                                alignment: .fill,
                                distribution: .fill)
        
        detailDocumnetView.hstack(detailDocumentImageView.setWidth(35),
                                  detailDocumentDescriptionLabel,
                                  spacing: 5,
                                  alignment: .fill,
                                  distribution: .fill)
        
        statementView.HStack(subscriptionInformationView,
                             termsOfUseInformationView,
                             privacyPolicyInformationView,
                             spacing: 1,
                             alignment: .fill,
                             distribution: .fillEqually)
        
        subscriptionInformationView.addSubview(subscriptionInformationButton)
        subscriptionInformationButton.centerYAnchor.constraint(equalTo: subscriptionInformationView.centerYAnchor).isActive = true
        subscriptionInformationButton.trailingAnchor.constraint(equalTo: subscriptionInformationView.trailingAnchor, constant: -5).isActive = true
        subscriptionInformationButton.leadingAnchor.constraint(equalTo: subscriptionInformationView.leadingAnchor, constant: 10).isActive = true
        
        termsOfUseInformationView.addSubview(termsOfUseInformationButton)
        termsOfUseInformationButton.centerInSuperview()
        
        privacyPolicyInformationView.addSubview(privacyPolicyInformationButton)
        privacyPolicyInformationButton.centerYAnchor.constraint(equalTo: privacyPolicyInformationView.centerYAnchor).isActive = true
        privacyPolicyInformationButton.leadingAnchor.constraint(equalTo: privacyPolicyInformationView.leadingAnchor, constant: 5).isActive = true
        privacyPolicyInformationButton.trailingAnchor.constraint(equalTo: privacyPolicyInformationView.trailingAnchor, constant: -10).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        restoreButton.addTarget(self, action: #selector(restorePurchase), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        subscribeButton.addTarget(self, action: #selector(subscribeButtonTapped), for: .touchUpInside)
        subscribeMonthlyButton.addTarget(self, action: #selector(subscribeMonthlyButtonTapped), for: .touchUpInside)
        
        subscriptionInformationButton.addTarget(self, action: #selector(showAboutSubscription), for: .touchUpInside)
        termsOfUseInformationButton.addTarget(self, action: #selector(showTermsOfUse), for: .touchUpInside)
        privacyPolicyInformationButton.addTarget(self, action: #selector(showPrivacyPolicy), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()

        DispatchQueue.main.async { [weak self] in
            var contentRect = CGRect.zero
            guard let scrollViewSubviews = self?.scrollView.subviews else { return }

            for view in scrollViewSubviews {
               contentRect = contentRect.union(view.frame)
            }

            self?.scrollView.contentSize = contentRect.size
        }
        
        subscribeButton.setGradientBackground(startColor: UIColor(rgb: 0x1BFFFF), endColor: UIColor(rgb: 0x2E3192))
    }
    
    @objc func restorePurchase() {
        InAppPurchaseManager.restorePurchase()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func subscribeButtonTapped() {
        let productIdentifier = InAppPurchaseManager.retrievedProducts[0].productIdentifier
        SwiftyStoreKit.purchaseProduct(productIdentifier, atomically: true) { [weak self] (result) in
            switch result {
            case .success(let purchase):
                print("Subscription successed.")
                // Deliver content from server, then:
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                    print("finished transaction.")
                }
                InAppPurchaseManager.verifyPurchase(with: productIdentifier)
                
                self?.dismiss(animated: true) {
                    SPAlert.present(title: "Purchase successfully.".localized(),
                                    preset: .done)
                }
                
            case .error(let error):
                print(error.localizedDescription)
                SPAlert.present(title: "Purchase failed.".localized(),
                                message: error.localizedDescription,
                                preset: .error)
            }
        }
    }

    @objc func subscribeMonthlyButtonTapped() {
        InAppPurchaseManager.purchaseProduct(with: InAppPurchaseManager.retrievedProducts[1].productIdentifier)
    }
    
    @objc func showAboutSubscription() {
        let viewController = AboutSubscriptionViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .pageSheet
        present(navController, animated: true, completion: nil)
    }
    
    @objc func showTermsOfUse() {
        let viewController = TermsOfUseViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .pageSheet
        present(navController, animated: true, completion: nil)
    }
    
    @objc func showPrivacyPolicy() {
        let viewController = PrivacyPolicyViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .pageSheet
        present(navController, animated: true, completion: nil)
    }
    
    deinit {
        print("PurchasePageViewController deallocated.")
    }
}
