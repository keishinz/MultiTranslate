//
//  TextTranslateViewController.swift
//  MultiTranslate
//
//  Created by Keishin CHOU on 2020/01/06.
//  Copyright © 2020 Keishin CHOU. All rights reserved.
//

import UIKit

import PMSuperButton

//import RAMAnimatedTabBarController
import KMPlaceholderTextView

class TextTranslateViewController: UIViewController {
    
    let exchangeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "exchange"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1).isActive = true
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .blue
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.purple.cgColor
        button.layer.cornerRadius = 10.0
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.green, for: .highlighted)
        button.backgroundColor = .gray
        return button
    }()
    
    let translateButton: PMSuperButton = {
        let button = PMSuperButton()
        button.borderColor = .white
        button.borderWidth = 2
        button.cornerRadius = 25
        button.shadowColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.shadowOpacity = 1
        button.shadowOffset.width = 1
        button.shadowOffset.height = 1
        button.shadowRadius = 5
        
        button.gradientEnabled = true
        button.gradientStartColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        button.gradientEndColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        button.gradientHorizontal = true
        button.ripple = true
        button.rippleColor = #colorLiteral(red: 0.9880490899, green: 0.7656863332, blue: 0.9337566495, alpha: 0.5442262414)
        
        button.setTitle("Translate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let sourceLanguageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label.isUserInteractionEnabled = true
        label.textAlignment = .right
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.frame = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Source Language Source"
        return label
    }()
    
    let targetLanguageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.frame = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Target Language"
        return label
    }()
    
    let sourceInputLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter text"
        label.backgroundColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sourceInputText: KMPlaceholderTextView = {
        let textView = KMPlaceholderTextView()
        textView.backgroundColor = .systemBackground
        textView.placeholder = "Enter text here"
        textView.layer.style = .none
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.masksToBounds = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    let sourceInputLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return view
    }()
    
    let sourceInputTextView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        let languageSelectView = UIView()
        languageSelectView.backgroundColor = .red
        
        let sourceInputView = UIView()
        sourceInputView.backgroundColor = .yellow
        
        let translateButtonView = UIView()
        translateButtonView.backgroundColor = .green
        
        let targetOutputView = UIView()
        targetOutputView.backgroundColor = .cyan
        
//        let textTranslateStackView = UIStackView(arrangedSubviews: [languageSelectView, sourceInputView, targetOutputView])
//        textTranslateStackView.axis = .vertical
//        textTranslateStackView.distribution = .fillProportionally
//        textTranslateStackView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(textTranslateStackView)
//        textTranslateStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        textTranslateStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        textTranslateStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        textTranslateStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.VStack(languageSelectView.setHeight(75),
                    sourceInputView.setHeight(200),
                    translateButtonView.setHeight(50),
                    targetOutputView,
                    spacing: 5,
                    alignment: .fill,
                    distribution: .fill)
        
        let sourceLanguageView = UIView()
        sourceLanguageView.backgroundColor = .purple
        
        let exchangeButtonView = UIView()
        exchangeButtonView.backgroundColor = .orange
        
        let targetLanguageView = UIView()
        targetLanguageView.backgroundColor = .gray
        
//        let languageSelectStackView = UIStackView(arrangedSubviews: [sourceLanguageView, exchangeButtonView, targetLanguageView])
//        languageSelectStackView.axis = .horizontal
//        languageSelectStackView.distribution = .fillEqually
//        languageSelectStackView.translatesAutoresizingMaskIntoConstraints = false
//
//        languageSelectView.addSubview(languageSelectStackView)
//        languageSelectStackView.topAnchor.constraint(equalTo: languageSelectView.topAnchor).isActive = true
//        languageSelectStackView.leadingAnchor.constraint(equalTo: languageSelectView.leadingAnchor).isActive = true
//        languageSelectStackView.trailingAnchor.constraint(equalTo: languageSelectView.trailingAnchor).isActive = true
//        languageSelectStackView.bottomAnchor.constraint(equalTo: languageSelectView.bottomAnchor).isActive = true
        
        languageSelectView.HStack(sourceLanguageView,
                                  exchangeButtonView.setWidth(65),
                                  targetLanguageView,
                                  spacing: 5,
                                  alignment: .fill,
                                  distribution: .fill)
        exchangeButtonView.centerXAnchor.constraint(equalTo: languageSelectView.centerXAnchor).isActive = true

        
        sourceLanguageView.addSubview(sourceLanguageLabel)
        sourceLanguageLabel.centerYAnchor.constraint(equalTo: sourceLanguageView.centerYAnchor).isActive = true
        sourceLanguageLabel.widthAnchor.constraint(equalTo: sourceLanguageView.widthAnchor).isActive = true
        
        exchangeButtonView.addSubview(exchangeButton)
        exchangeButton.centerXAnchor.constraint(equalTo: exchangeButtonView.centerXAnchor).isActive = true
        exchangeButton.centerYAnchor.constraint(equalTo: exchangeButtonView.centerYAnchor).isActive = true

        targetLanguageView.addSubview(targetLanguageLabel)
        targetLanguageLabel.centerYAnchor.constraint(equalTo: targetLanguageView.centerYAnchor).isActive = true
        targetLanguageLabel.widthAnchor.constraint(equalTo: targetLanguageView.widthAnchor).isActive = true


        
        sourceInputView.VStack(sourceInputLabelView.setHeight(30),
                               sourceInputTextView,
                               spacing: 5,
                               alignment: .fill,
                               distribution: .fill)
        
        sourceInputLabelView.addSubview(sourceInputLabel)
        sourceInputLabel.leadingAnchor.constraint(equalTo: sourceInputLabelView.leadingAnchor, constant: 20).isActive = true
        sourceInputLabel.topAnchor.constraint(equalTo: sourceInputLabelView.topAnchor).isActive = true
        sourceInputLabel.bottomAnchor.constraint(equalTo: sourceInputLabelView.bottomAnchor).isActive = true
        sourceInputLabel.widthAnchor.constraint(equalTo: sourceInputLabelView.widthAnchor, multiplier: 0.5).isActive = true
        
        sourceInputTextView.addSubview(sourceInputText)
        sourceInputText.leadingAnchor.constraint(equalTo: sourceInputTextView.leadingAnchor, constant: 10).isActive = true
        sourceInputText.trailingAnchor.constraint(equalTo: sourceInputTextView.trailingAnchor, constant: -10).isActive = true
        sourceInputText.topAnchor.constraint(equalTo: sourceInputTextView.topAnchor, constant: 10).isActive = true
        sourceInputText.bottomAnchor.constraint(equalTo: sourceInputTextView.bottomAnchor, constant: -10).isActive = true
        
        translateButtonView.addSubview(translateButton)
        translateButton.topAnchor.constraint(equalTo: translateButtonView.topAnchor).isActive = true
        translateButton.leadingAnchor.constraint(equalTo: translateButtonView.leadingAnchor, constant: 50).isActive = true
        translateButton.trailingAnchor.constraint(equalTo: translateButtonView.trailingAnchor, constant: -50).isActive = true
        translateButton.bottomAnchor.constraint(equalTo: translateButtonView.bottomAnchor).isActive = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sourceLanguageRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectLanguage))
        sourceLanguageLabel.addGestureRecognizer(sourceLanguageRecognizer)
        let targetLanguageRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectLanguage))
        targetLanguageLabel.addGestureRecognizer(targetLanguageRecognizer)
        
        exchangeButton.addTarget(self, action: #selector(exchangeLanguage), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        translateButton.addTarget(self, action: #selector(doTranslate), for: .touchUpInside)
        
        sourceInputText.delegate = self

    }
    
    @objc func selectLanguage() {
        //present picker view modal
        let viewController = ChangeLanguageViewController()
        let navController = UINavigationController(rootViewController: viewController)

        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    @objc func exchangeLanguage() {
        
        let exchangeText = targetLanguageLabel.text
        
        UIView.animate(withDuration: 0.25, animations: {
            self.exchangeButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.exchangeButton.transform = self.exchangeButton.transform.rotated(by: CGFloat.pi)
            self.targetLanguageLabel.text = self.sourceLanguageLabel.text
            self.sourceLanguageLabel.text = exchangeText
        }, completion: nil)
        
        print("exchange button pressed.")
    }
    
    @objc func clearText() {
        sourceInputText.text = ""
    }
    
    @objc func doTranslate() {
        print("do translate")
    }

}

extension TextTranslateViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        sourceInputLabelView.addSubview(clearButton)
        clearButton.topAnchor.constraint(equalTo: sourceInputLabelView.topAnchor).isActive = true
        clearButton.bottomAnchor.constraint(equalTo: sourceInputLabelView.bottomAnchor).isActive = true
        clearButton.trailingAnchor.constraint(equalTo: sourceInputLabelView.trailingAnchor, constant: -10).isActive = true
        clearButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        clearButton.isHidden = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if sourceInputText.text == "" {
            clearButton.isHidden = true
        }
    }
    
    
}

