//
//  DrinkModel.swift
//  DrinkDiary
//
//  Created by Paige Closser (pclosser@iu.edu) and Meghna Nimmala (mnimmala@iu.edu)
//
//  on 4/22/25.
//

import Foundation
import UIKit

class DrinkModel: Codable{
    
    var currentIndex = 0
    
    var titles: [String] = []
    var dates: [String] = []
    var details: [String] = []
    var images: [UIImage] = []
    
    var currentLatitude: Double?
    var currentLongitude: Double?
    
    enum CodingKeys: String, CodingKey {
        //indexing drink entries
        case currentIndex
        //titles of drink entries
        case titles
        //dates of drink entries
        case dates
        //details/description of drinks
        case details
        //image arrays
        case imageDataArray
        //getting latitude and longitude of user's location
        case currentLatitude
        case currentLongitude
    }

    // encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        //encodes current index using CodingKey
        try container.encode(currentIndex, forKey: .currentIndex)
        //encodes array of titles, dates, and details regarding drinks
        try container.encode(titles, forKey: .titles)
        try container.encode(dates, forKey: .dates)
        try container.encode(details, forKey: .details)
        //encodes latitude and longitude of user's location
        try container.encode(currentLatitude, forKey: .currentLatitude)
        try container.encode(currentLongitude, forKey: .currentLongitude)

        // Convert UI Image array to data object array
        let imageDataArray = images.compactMap { $0.pngData() }
        //image data array
        try container.encode(imageDataArray, forKey: .imageDataArray)
    }

    // decoding
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //decodes index as int
        currentIndex = try container.decode(Int.self, forKey: .currentIndex)
        //decodes array of titles as array of strings
        titles = try container.decode([String].self, forKey: .titles)
        //decodes array of dates as an array of strings
        dates = try container.decode([String].self, forKey: .dates)
        //decodes array of details as array of strings
        details = try container.decode([String].self, forKey: .details)
        //decodes latitude and longitude of
        currentLatitude = try container.decodeIfPresent(Double.self, forKey: .currentLatitude)
        currentLongitude = try container.decodeIfPresent(Double.self, forKey: .currentLongitude)

        // decode image data into UI Images
        let imageDataArray = try container.decode([Data].self, forKey: .imageDataArray)
        images = imageDataArray.compactMap { UIImage(data: $0) }
    }

    // Default init
    init(){
        
        titles = ["Hello! Welcome to your Drink Diary!"]
        dates = ["M/D/Y"]
        details = ["This is where you'll describe your drink! Remeber to mention specifics like the type of drink, amount, etc."]
        images = [UIImage()]
    }
    
    //GETTERS
    func getNextTitle() -> String{
        currentIndex += 1
        
        if currentIndex >= titles.count {
            
            currentIndex = 0
            return titles[currentIndex]
        }
        print("titles number: \(titles.count)")
        return titles[currentIndex]

    }
    
    func getPreviousTitle() -> String{
        currentIndex -= 1
        
        if currentIndex < 0 {
            
            currentIndex = titles.count - 1
            return titles[currentIndex]
        }
        return titles[currentIndex]
    }
    
    func getDetail() -> String{
        return details[self.currentIndex]
    }
    
    func getDate() -> String{
        return dates[self.currentIndex]
        
    }
    
    func getImage() -> UIImage{
        print("images number: \(images.count)")
        return images[self.currentIndex]

    }
    
    //ADDERS
    func addImage(image: UIImage){
        print("image added")
        images.append(image)
    }
    
    func addTile(title: String){
        titles.append(title)
    }
    
    func addDate(date: String){
        dates.append(date)
    }
    
    func addDetail(detail: String){
        details.append(detail)
    }
    
    func addLatitude(latitude: Double?) {
        currentLatitude = latitude
    }

    func addLongitude(longitude: Double?) {
        currentLongitude = longitude
    }
    
    //SETTERS
    func setCurrentDate(date: String){
        self.dates[self.currentIndex] = date
    }
    
    func setCurrentDetail(detail: String){
        self.details[self.currentIndex] = detail
    }
    
    func setCurrentTitle(title: String){
        self.titles[self.currentIndex] = title
    }
    
    func setCurrentLatitude(latitude: Double?) {
        currentLatitude = latitude
    }
    
    func setCurrentLongitude(longitude: Double?) {
        currentLongitude = longitude
    }
    
    
}
