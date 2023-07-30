//
//  Errors.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/29/23.
//

import Foundation


enum AuthenticationError: Error {
    case invalidCredentials
    case invalidSignupCredentials
    case custom(errorMessage: String)
}


enum UserError: Error {
    case custom(errorMessage: String)
}
