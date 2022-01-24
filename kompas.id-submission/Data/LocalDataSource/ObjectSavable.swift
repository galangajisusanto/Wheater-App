//
//  ObjectSavable.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 24/01/22.
//

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}
