//
//  NetworkModel.swift
//  AppCakeTask
//
//  Created by Rizwan on 10/8/22.
//

import Foundation


protocol NetResponse: Codable {
    var statusCode: Int? { get }
    var message: String? { get }
}
