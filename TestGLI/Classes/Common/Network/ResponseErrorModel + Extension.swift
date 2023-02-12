//
//  ResponseErrorModel + Extension.swift
//  TestGLI
//
//  Created by SehatQ on 10/02/23.
//

import Foundation

extension ResponseErrorModel {
    init(systemError: NSError) {
        self.init()
        self.status = systemError.code as NSNumber

        if systemError.code == NSURLErrorNotConnectedToInternet ||
            systemError.code == NSURLErrorNetworkConnectionLost  ||
            systemError.code == NetworkConfiguration.kGatewayTimeoutErrorCode {
            
            self.title = "Koneksi Error"
            self.detail = "Oops! Terjadi kesalahan pada server kami.Mohon coba kembali"
        } else {
            self.title = systemError.localizedDescription
            self.detail = systemError.localizedRecoverySuggestion
        }
    }
}
