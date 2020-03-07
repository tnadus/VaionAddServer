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

protocol AddServerPresenterNavigatorProtocol {
    var onSuccessScreen: (()-> Void)? { get set }
}

class AddServerPresenter: AddServerPresenterProtocol, AddServerPresenterNavigatorProtocol {
    
    //Constants
    private enum Strings {
        static let placeholder = "IP Address"
        static let buttonTitle = "OK"
    }
    
    //Properties
    weak var managedView: AddServerViewProtocol?
    var addServerUsecase: AddServerUsecaseProtocol
    
    //Navigation
    var onSuccessScreen: (()-> Void)?
    
    init(addServerUsecase: AddServerUsecaseProtocol) {
        self.addServerUsecase = addServerUsecase
    }
    
    func start() {
        managedView?.updateView(placeholder: Strings.placeholder, buttonTitle: Strings.buttonTitle)
    }
    
    func onOKButtonTapped(ipAddress: String) {
        addServerUsecase.addServer(ipAddress: ipAddress) {
            onSuccessScreen?()
        }
    }
}
