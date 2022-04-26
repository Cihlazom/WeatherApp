//
//  CoreDataManager.swift
//  Weather
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func addNewCity(name: String, lat: String, lon: String)
    func returnAllCities() -> [City]?
}

class CoreDataManager: CoreDataManagerProtocol {
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext


    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func returnAllCities() -> [City]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        guard let cities = try? viewContext.fetch(fetchRequest) as? [City] else {
            return []
        }
        return cities
    }
    
    func addNewCity(name: String, lat: String, lon: String) {
        let city = City(context: viewContext)
        city.name = name
        city.lon = lon
        city.lat = lat
        do {
            try viewContext.save()
        } catch let error {
            print(error)
        }
    }
}
