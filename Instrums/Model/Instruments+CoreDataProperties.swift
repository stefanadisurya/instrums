//
//  Instruments+CoreDataProperties.swift
//  Instrums
//
//  Created by Stefan Adisurya on 01/05/21.
//
//

import Foundation
import CoreData


extension Instruments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Instruments> {
        return NSFetchRequest<Instruments>(entityName: "Instruments")
    }

    @NSManaged public var name: String?
    @NSManaged public var fact: String?

}

extension Instruments : Identifiable {

}
