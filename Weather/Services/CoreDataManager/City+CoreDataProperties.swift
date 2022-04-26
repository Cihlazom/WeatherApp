//
//  City+CoreDataProperties.swift
//  Weather
//
//  Created by Vladislav on 26.04.2022.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var lat: String?
    @NSManaged public var lon: String?

}

extension City : Identifiable {

}
