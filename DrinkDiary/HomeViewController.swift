//
//  HomeViewController.swift
//  DrinkDiary
//
//  Created by Paige Closser (pclosser@iu.edu) and Meghna Nimmala (mnimmala@iu.edu)
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var drinkLabel: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    var appDelegate: AppDelegate?
    var myDrinkModel: DrinkModel?
    
    @IBAction func nextEntry(_ sender: Any) {
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myDrinkModel = self.appDelegate?.myDrinkModel
        
        var titleText : String = self.myDrinkModel?.getNextTitle() ?? "No more entries"
        var dateText : String = self.myDrinkModel?.getDate() ?? "No more entries"
        var drinkText : String = self.myDrinkModel?.getDetail() ?? "No more entries"
        
        
        self.titleLabel.text = titleText
        self.dateLabel.text = dateText
        self.drinkLabel.text = drinkText
        self.imageView.image = self.myDrinkModel?.getImage()
    }
    
    @IBAction func previousEntry(_ sender: Any) {
        
        var titleText : String = self.myDrinkModel?.getPreviousTitle() ?? "No more entries"
        var dateText : String = self.myDrinkModel?.getDate() ?? "No more entries"
        var drinkText : String = self.myDrinkModel?.getDetail() ?? "No more entries"
        var images = self.myDrinkModel?.getImage()
        
        
        self.titleLabel.text = titleText
        self.dateLabel.text = dateText
        self.drinkLabel.text = drinkText
        self.imageView.image = images
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "Click NEXT to view entries"
        self.dateLabel.text = ""
        self.drinkLabel.text = "Please click NEXT to view your entries"
        
        
    }
}
