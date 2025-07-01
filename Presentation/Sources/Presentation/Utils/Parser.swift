//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

struct Parser {
    static func parseCommand(from input: String) -> Command? {
        let components = input.split(separator: " ", maxSplits: 2).map{ String($0) }
        
        guard let command = components[safe: 0] else { return nil }
        let firstArgument = components[safe: 1]
        let secondArgument = components[safe: 2]
        
        return Command(command: command, firstArgument: firstArgument, secondArgument: secondArgument)
    }
}
