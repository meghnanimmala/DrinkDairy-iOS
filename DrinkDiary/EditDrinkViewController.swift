//
//  EditDrinksViewController.swift
//  DrinkDiary
//
//  Created by Paige Closser (pclosser@iu.edu) and Meghna Nimmala (mnimmala@iu.edu)
//
// the following 'credit' comments mean we are giving credit to Jacob Hunt huntjac@iu.edu and Sarah McMahon skmcmaho@iu.edu for helping us

import UIKit
import MapKit
import CoreLocation
import Photos
import PhotosUI

class EditDrinkViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    var appDelegate: AppDelegate?
    var myDrinkModel: DrinkModel?
    
    let pickerController = UIImagePickerController()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    
    
    let locationManager = CLLocationManager()
    var cafeLocation: CLLocationCoordinate2D?
    
//    let datePicker = UIDatePicker()
    
    @IBAction func buttonEditAction(_ sender: Any) {
        
        self.myDrinkModel!.setCurrentTitle(title: titleTextField.text!)
        self.myDrinkModel!.setCurrentDate(date: dateTextField.text!)
        self.myDrinkModel!.setCurrentDetail(detail: descriptionTextField.text!)
        
        if let location = cafeLocation {
            myDrinkModel?.setCurrentLatitude(latitude: location.latitude)
            myDrinkModel?.setCurrentLongitude(longitude: location.longitude)
        }
        
        if let lsplitViewController = self.splitViewController{
            
            if let lNavigationViewController = lsplitViewController.viewControllers[0] as? UINavigationController{
                
                if let lTableViewController = lNavigationViewController.viewControllers[0] as? UITableViewController{
                    
                    if let lTableView = lTableViewController.view as? UITableView{
                        
                        lTableView.reloadData()
                    }
                }
            }
        }
        
        saveDrink()
        
    }
    
    
    @IBAction func buttonOKAction(_ sender: Any) {
        
        self.myDrinkModel!.addTile(title: titleTextField.text!)
        self.myDrinkModel!.addDate(date: dateTextField.text!)
        self.myDrinkModel!.addDetail(detail: descriptionTextField.text!)
        self.myDrinkModel!.addImage(image: imageView.image!)
        
        if let lsplitViewController = self.splitViewController{
            
            if let location = cafeLocation {
                 myDrinkModel?.addLatitude(latitude: location.latitude)
                 myDrinkModel?.addLongitude(longitude: location.longitude)
             }
            
            if let lNavigationViewController = lsplitViewController.viewControllers[0] as? UINavigationController{
                
                if let lTableViewController = lNavigationViewController.viewControllers[0] as? UITableViewController{
                    
                    if let lTableView = lTableViewController.view as? UITableView{
                        
                        lTableView.reloadData()
                    }
                }
            }
        }
        
        saveDrink()
    }
    
    //button to click when they want to upload an image, needs to be tweaked i think
    @IBAction func imageButtonAction(_ sender: UIButton){
        presentImagePicker()
        print("button pushed")
    }
    
    private func presentImagePicker(){
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            self.imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func startLocationServices() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func saveDrink() { //credit
        
        do{
            let docDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let plistURL = docDirectoryURL.appendingPathComponent("DrinksModel.plist")
            
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(myDrinkModel)
            try data.write(to: plistURL)
        }
        catch {
            print("you tried")
        }
        
    }
    
    override func viewDidLoad() {
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myDrinkModel = self.appDelegate?.myDrinkModel
        
        super.viewDidLoad()
        startLocationServices()
        
        // set delegate and show the user's location
        if let mapView = self.mapView {
            mapView.delegate = self
            mapView.showsUserLocation = true
            // Do any additional setup after loading the view.
        }
//        datePicker.datePickerMode = .date
//        view.addSubview(datePicker)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
