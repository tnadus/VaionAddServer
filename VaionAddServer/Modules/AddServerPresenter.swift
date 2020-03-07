//
//  AddServerPresenter.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import Foundation

protocol AddServerViewProtocol: class {
    func updateView(placeholder: String, buttonTitle: String)
}

protocol AddServerPresenterProtocol {
    
}

class AddServerPresenter: AddServerPresenterProtocol {
    
    //Constants
    private enum Strings {
        static let placeholder = "IP Address"
        static let buttonTitle = "OK"
    }
    
    weak var managedView: AddServerViewProtocol?
    var addServerUsecase: AddServerUsecaseProtocol
    
    init(addServerUsecase: AddServerUsecaseProtocol) {
        self.addServerUsecase = addServerUsecase
    }
    
    func start() {
        managedView?.updateView(placeholder: Strings.placeholder, buttonTitle: Strings.buttonTitle)
    }
    
    func onOKButtonTapped() {
        addServerUsecase.addServer()
    }
    
}
