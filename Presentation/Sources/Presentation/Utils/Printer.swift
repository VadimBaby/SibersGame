//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

enum PrintError {
    case unrecognizedCommand
    
    var message: String {
        switch self {
        case .unrecognizedCommand: "You entered the wrong command"
        }
    }
}

struct Printer {
    enum Color {
        case green, red, orange
        
        func colorMessage(from value: String) -> String {
            switch self {
            case .green: "\u{001B}[32m\(value)\u{001B}[0m"
            case .red: "\u{001B}[31m\(value)\u{001B}[0m"
            case .orange: "\u{001B}[38;5;208m\(value)\u{001B}[0m"
            }
        }
    }
    static func print(_ value: String) {
        Swift.print(value)
    }
    
    static func print(error: PrintError) {
        print(error.message, color: .red)
    }
    
    static func print<T: Error>(error: T) {
        print(error.localizedDescription, color: .red)
    }
    
    static func print(_ value: String, color: Color) {
        print(color.colorMessage(from: value))
    }
}
