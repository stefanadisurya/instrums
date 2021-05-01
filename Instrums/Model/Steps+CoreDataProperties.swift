//
//  Steps+CoreDataProperties.swift
//  Instrums
//
//  Created by Stefan Adisurya on 01/05/21.
//
//

import Foundation
import CoreData


extension Steps {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Steps> {
        return NSFetchRequest<Steps>(entityName: "Steps")
    }

    @NSManaged public var step: String?

}

extension Steps : Identifiable {

}
