//
//  SQLogger.swift
//  SQLogger
//
//  Created by SehatQ on 28/07/22.
//

import Foundation

public enum LogType: Int {
    case kTrace = 1 //Default black
    case kDebug = 2
    case kInfo = 3
    case kWarning = 4
    case kError = 5
    case kImportant = 6
    case kVeryImportant = 7
    case kNetworkRequest = 8
    case kNetworkResponseSuccess = 9
    case kNetworkResponseError = 10
}

public enum PrintColors: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
    
    func name() -> String {
        switch self {
        case .black: return "Black"
        case .red: return "Red"
        case .green: return "Green"
        case .yellow: return "Yellow"
        case .blue: return "Blue"
        case .magenta: return "Magenta"
        case .cyan: return "Cyan"
        case .white: return "White"
        }
    }
}

public class SQLogger {
    public var isLogEnabled = true {
        didSet {
            if isLogEnabled, !oldValue {
                isLogEnabled = false
            }
        }
    }
    
    public class var sharedLogger: SQLogger {
        struct DefaultSingleton {
            static let loggerInstance = SQLogger()
        }
        return DefaultSingleton.loggerInstance
    }
    
    // swiftlint:disable no_direct_standard_out_logs
    // reason: function for print
    public class func log(_ logString: Any, logType: LogType? = .kTrace, isColorEnabled: Bool? = false) {
        let isColor = isColorEnabled ?? false
        if (SQLogger.sharedLogger.isLogEnabled == false && logType != .kImportant) {
            return
        } else {
            switch logType {
            case .kDebug?:
                print("SQ: \(isColor ? PrintColors.magenta.rawValue : "")\(logString)")
            case .kInfo?:
                print("SQ: \(isColor ? PrintColors.green.rawValue : "")\(logString)")
            case .kWarning?:
                print("SQ: \(isColor ? PrintColors.blue.rawValue : "")\(logString)")
            case .kError?:
                print("SQ: \(isColor ? PrintColors.red.rawValue : "")\(logString)")
            case .kImportant?:
                print("SQ: \(isColor ? PrintColors.black.rawValue : "")\(logString)")
            case .kNetworkRequest?:
                print("SQ-NETWORK-REQUEST: \(Date.init()) \(isColor ? PrintColors.black.rawValue : "📔:")\(logString)")
            case .kNetworkResponseSuccess?:
                print("SQ-NETWORK-RESPONSE: \(Date.init()) \(isColor ? PrintColors.black.rawValue : "📗:")\(logString)")
            case .kNetworkResponseError?:
                print("SQ-NETWORK-ERROR: \(Date.init()) \(isColor ? PrintColors.black.rawValue : "🛑:")\(logString)")
            default:
                print("SQ: \(isColor ? PrintColors.black.rawValue : "")\(logString)")
            }
        }
    }
}

