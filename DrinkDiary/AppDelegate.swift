//
//  AppDelegate.swift
//  DrinkDiary
//
// Created by Paige Closser (pclosser@iu.edu) and Meghna Nimmala (mnimmala@iu.edu)
// the following 'credit' comments mean we are giving credit to Jacob Hunt huntjac@iu.edu and Sarah McMahon skmcmaho@iu.edu for helping us

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var myDrinkModel : DrinkModel = DrinkModel()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do { //credit
            let docDirectoryURLs = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let plistURL = docDirectoryURLs.appendingPathComponent("DrinksModel.plist")
            
            if FileManager.default.fileExists(atPath: plistURL.path) {
                let data = try Data(contentsOf: plistURL)
                let decoder = PropertyListDecoder()
                myDrinkModel = try decoder.decode(DrinkModel.self, from: data)
                print("Model Loaded!")
            }
            else {
                print("Model Not Found!")
            }
        } catch{
            print("Could not load data")
        }
        
        reloadModel()
        
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
    
    func reloadModel(){
        do { //credit
            let docDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let plistURL = docDirectoryURL.appendingPathComponent("DrinksModel.plist")

            if FileManager.default.fileExists(atPath: plistURL.path) {
                let data = try Data(contentsOf: plistURL)
                let decoder = PropertyListDecoder()
                self.myDrinkModel = try decoder.decode(DrinkModel.self, from: data)
                print("Model reloaded successfully.")
            } else {
                print("No saved model file found.")
            }
        } catch {
            print("Error reloading model: \(error.localizedDescription)")
        }
    }


}

