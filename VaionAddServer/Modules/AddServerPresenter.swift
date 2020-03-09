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
    func showSpinner()
    func hideSpinner()
}

protocol AddServerPresenterProtocol {
    func start()
    func onOKButtonTapped(ipAddress: String)
    var managedView: AddServerViewProtocol? { get set }
}

protocol AddServerPresenterNavigatorProtocol {
    var onSuccessScreen: (()-> Void)? { get set }
    var onLoginScreen: ((String) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
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
    var onLoginScreen: ((String) -> Void)?
    var onError: ((Error) -> Void)?
    
    init(addServerUsecase: AddServerUsecaseProtocol) {
        self.addServerUsecase = addServerUsecase
    }
    
    func start() {
        managedView?.updateView(placeholder: Strings.placeholder, buttonTitle: Strings.buttonTitle)
    }
    
    func onOKButtonTapped(ipAddress: String) {
        managedView?.showSpinner()
        addServerUsecase.addServer(ipAddress: ipAddress, credentials: nil) {
            [weak self] result in
            
            switch result {
            case .success:
                self?.onSuccessScreen?()
            case .login:
                self?.onLoginScreen?(ipAddress)
            case .error(let error):
                self?.onError?(error)
            }
            self?.managedView?.hideSpinner()
        }
    }
}
