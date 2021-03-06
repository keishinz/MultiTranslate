//
//  AppDelegate.swift
//  MultiTranslate
//
//  Created by Keishin CHOU on 2020/01/06.
//  Copyright © 2020 Keishin CHOU. All rights reserved.
//

import AVFoundation
import UIKit
import StoreKit

import Firebase
//import IQKeyboardManager
import RealmSwift
import SPAlert
import SwiftyStoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        IQKeyboardManager.shared().isEnabled = true
        
        if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
            print(fileURL)
        }
        
        initializeInAppPurchase()

        initializeRealm()
        
        initializeFirebase()
        
        initializeUserDefaults()
        
        initializeCloudDatabase()
        
        FBOfflineTranslate.initializeFBTranslation()
        
        initializeAVAudioSession()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func initializeUserDefaults() {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set("GuestUser", forKey: Constants.userTypeKey)
        
        let lastLaunchMonth = userDefaults.integer(forKey: Constants.lastLaunchMonthKey)
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LL"
        let nameOfMonth = dateFormatter.string(from: now)
        if let intValueOfCurrentMonth = Int(nameOfMonth) {
            print("This month is \(intValueOfCurrentMonth)")
            
            if lastLaunchMonth == 0 {
                //First launch of the app.
                userDefaults.set(intValueOfCurrentMonth, forKey: Constants.lastLaunchMonthKey)
                print("lastLaunchMonth is 0")
            } else if lastLaunchMonth != intValueOfCurrentMonth {
//            } else if lastLaunchMonth != 4 { // for test
                //Month has changed since last launch.
                let currentCount = userDefaults.integer(forKey: Constants.translatedCharactersCountKey)
                updateMonthlyCountInfo(update: currentCount)
                
                userDefaults.set(intValueOfCurrentMonth, forKey: Constants.lastLaunchMonthKey)
                userDefaults.set(0, forKey: Constants.translatedCharactersCountKey)
                CloudKitManager.refreshCloudDatabaseCountData()
                print("lastLaunchMonth is not 0, but month has changed.")
            }
            
            print("lastLaunchMonth is \(userDefaults.integer(forKey: Constants.lastLaunchMonthKey))")
            print("translatedCharactersCount is \(userDefaults.integer(forKey: Constants.translatedCharactersCountKey))")
            translatedCharacterCountLocal = userDefaults.integer(forKey: Constants.translatedCharactersCountKey)
        }
        
        let isAppEverLaunched = UserDefaults.standard.bool(forKey: Constants.isAppEverLauchedKey)
        if !isAppEverLaunched {
            let englishTextIndex = SupportedLanguages.gcpLanguageList.firstIndex(of: "English".localized())
            let spanishTextIndex = SupportedLanguages.gcpLanguageList.firstIndex(of: "Spanish".localized())
            let chineseTextIndex = SupportedLanguages.gcpLanguageList.firstIndex(of: "Chinese (Mandarin)".localized())
            let japaneseTextIndex = SupportedLanguages.gcpLanguageList.firstIndex(of: "Japanese".localized())
            let englishVisionIndex = SupportedLanguages.visionRecognizerSupportedLanguage.firstIndex(of: "English".localized())
            let spanishSpeechIndex = SupportedLanguages.speechRecognizerSupportedLanguage.firstIndex(of: "Spanish".localized())
            let englishSpeechIndex = SupportedLanguages.speechRecognizerSupportedLanguage.firstIndex(of: "English".localized())
            
            userDefaults.set(spanishTextIndex, forKey: Constants.textSourceLanguageIndexKey)
            userDefaults.set(englishTextIndex, forKey: Constants.textTargetLanguageIndexKey)
            
            userDefaults.set(englishVisionIndex, forKey: Constants.cameraSourceLanguageIndexKey)
            userDefaults.set(japaneseTextIndex, forKey: Constants.cameraTargetLanguageIndexKey)
            
            userDefaults.set(spanishSpeechIndex, forKey: Constants.voiceSourceLanguageIndexKey)
            userDefaults.set(englishTextIndex, forKey: Constants.voiceTargetLanguageIndexKey)
            
            userDefaults.set(spanishSpeechIndex, forKey: Constants.conversationSourceLanguageIndexKey)
            userDefaults.set(englishSpeechIndex, forKey: Constants.conversationTargetLanguageIndexKey)
            
            userDefaults.set(englishVisionIndex, forKey: Constants.imageSourceLanguageIndexKey)
            userDefaults.set(chineseTextIndex, forKey: Constants.imageTargetLanguageIndexKey)
            
            userDefaults.set(englishVisionIndex, forKey: Constants.docSourceLanguageIndexKey)
            userDefaults.set(japaneseTextIndex, forKey: Constants.docTargetLanguageIndexKey)
            
            userDefaults.set(englishVisionIndex, forKey: Constants.arSourceLanguageIndexKey)
            userDefaults.set(englishTextIndex, forKey: Constants.arTargetLanguageIndexKey)
        }
    }
    
    func initializeRealm() {
//        let config = Realm.Configuration(
//          // 新しいスキーマバージョンを設定します。以前のバージョンより大きくなければなりません。
//          // （スキーマバージョンを設定したことがなければ、最初は0が設定されています）
//          schemaVersion: 1,
//
//          // マイグレーション処理を記述します。古いスキーマバージョンのRealmを開こうとすると
//          // 自動的にマイグレーションが実行されます。
//          migrationBlock: { migration, oldSchemaVersion in
//            // 最初のマイグレーションの場合、`oldSchemaVersion`は0です
//            if (oldSchemaVersion < 1) {
//              // 何もする必要はありません！1
//              // Realmは自動的に新しく追加されたプロパティと、削除されたプロパティを認識します。
//              // そしてディスク上のスキーマを自動的にアップデートします。
//            }
//          })
//
//        // デフォルトRealmに新しい設定を適用します
//        Realm.Configuration.defaultConfiguration = config
        
        _ = try! Realm()
    }
    
    func initializeCloudDatabase() {
        CloudKitManager.isCountRecordEmpty {(isEmpty) in
            if isEmpty {
                CloudKitManager.initializeCloudDatabase()
            } else {
                CloudKitManager.queryCloudDatabaseCountData { [weak self] (result, error) in
                    if let result = result {
                        translatedCharacterCountCloud = result
                        print("cloudDBTranslatedCharacters is \(result)")
                        self?.checkCharacterCounts()
                    } else {
                        print("queryCloudDatabaseCountData error \(error!.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func checkCharacterCounts() {
        translatedCharacterCountLocal = max(translatedCharacterCountLocal, translatedCharacterCountCloud)
        translatedCharacterCountCloud = max(translatedCharacterCountLocal, translatedCharacterCountCloud)
    }
    
    func initializeFirebase() {
        FirebaseApp.configure()
    }
    
    func initializeInAppPurchase() {
        let skProduct = SKProduct()
        for _ in 0 ... 5 {
            InAppPurchaseManager.retrievedProducts.append(skProduct)
        }
        
        InAppPurchaseManager.retrieveProductsInfo(with: Constants.inAppPurchaseProductIdentifiersSet)
        
        for id in Constants.inAppPurchaseProductIdentifiers {
            InAppPurchaseManager.verifyPurchase(with: id)
        }
        
        InAppPurchaseManager.completeIAPTransactions()
    }
    
    func initializeAVAudioSession() {
        // Get the singleton instance.
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category, mode, and options.
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set audio session category.")
        }
        ///https://developer.apple.com/documentation/avfoundation/avaudiosession
        ///https://developer.apple.com/documentation/avfoundation/avaudiosession/category
        ///https://developer.apple.com/documentation/avfoundation/avaudiosession/mode
        ///https://developer.apple.com/documentation/avfoundation/avaudiosession/categoryoptions
        ///https://stackoverflow.com/questions/51010390/avaudiosession-setcategory-swift-4-2-ios-12-play-sound-on-silent
        ///https://stackoverflow.com/questions/1022992/how-to-get-avaudioplayer-output-to-the-speaker
    }
    
    func updateMonthlyCountInfo(update count: Int) {
       
        var userID = "unknownID"
        
        ICloudUserIDProvider.getUserID { [weak self] (response) in
            switch response {
            case .success(let record):
                print("recordName: \(record.recordName)")
                userID = record.recordName
                self?.sendFirebaseRecord(id: userID, count: count)
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            case .notSignedIn:
                print("please sign in to iCloud")
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    func sendFirebaseRecord(id: String, count: Int) {
//        let db = Firestore.firestore()
//        db.collection(Constants.FireStore.collectionName).addDocument(data: [
//            Constants.FireStore.idField: id,
//            Constants.FireStore.countField: count,
//            Constants.FireStore.dateField: Date(),
//        ]) { (error) in
//            if let e = error {
//                print("There was an issue saving data to firestore, \(e)")
//            } else {
//                print("Successfully saved data.")
//            }
//        }
        
        let db = Firestore.firestore()
        let dataSet: [String : Any] = [
            "monthly count": count,
            "time stamp": Date()
        ]
        
        db.collection(Constants.FireStore.collectionName).document(id).setData(dataSet) { (error) in
            if let e = error {
                print("There was an issue saving data to firestore, \(e)")
            } else {
                print("Successfully saved data.")
            }
        }
        //Use user id as Firestore document name.
        ///https://firebase.google.com/docs/firestore/manage-data/add-data?authuser=0
    }
    
}
