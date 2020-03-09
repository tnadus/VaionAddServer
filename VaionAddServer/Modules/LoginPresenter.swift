//
//  LoginPresenter.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: class {
    func updateView(viewModel: LoginViewModel)
    func showSpinner()
    func hideSpinner()
}

protocol LoginPresenterProtocol: class {
    func start()
    func onButtonOKTapped(credentials: Credentials)
    func onButtonCancelTapped()
    var managedView: LoginViewProtocol? { get set }
}

protocol LoginPresenterNavigatorProtocol {
    var onSuccessScreen: (() -> Void)? { get set }
    var onUnauthorized: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
}

class LoginPresenter: LoginPresenterProtocol, LoginPresenterNavigatorProtocol {
    
    //Properties
    let addServerUsecase: AddServerUsecaseProtocol
    let ipAddress: String
    weak var managedView: LoginViewProtocol?
    
    //navigation
    var onSuccessScreen: (() -> Void)?
    var onUnauthorized: (() -> Void)?
    var onError: ((Error) -> Void)?
    var onCancelled: (() -> Void)?
    
    init(addServerUsecase: AddServerUsecaseProtocol,
         ipAddress: String) {
        self.addServerUsecase = addServerUsecase
        self.ipAddress = ipAddress
    }
    
    func start() {
        let viewModel = LoginViewModel(placeholderUsername: "Username", placeholderPassword: "Password", buttonTitleOK: "OK", buttonTitleCancel: "Cancel")
        managedView?.updateView(viewModel: viewModel)
    }
    
    func onButtonOKTapped(credentials: Credentials) {
        managedView?.showSpinner()
        
        addServerUsecase.addServer(ipAddress: self.ipAddress, credentials: credentials) {
                                    [weak self] result in
            switch result {
            case .success:
                self?.onSuccessScreen?()
            case .login:
                self?.onUnauthorized?()
            case .error(let error):
                self?.onError?(error)
            }
            self?.managedView?.hideSpinner()
        }
    }
    
    func onButtonCancelTapped() {
        onCancelled?()
    }
}
