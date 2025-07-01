//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

public protocol MainCoordinatorViewProtocol: AnyObject {
    func didEnterString(_ value: String)
    func viewDidAppear()
}
