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

protocol LoginPresenterProtocol {
    func start()
    func onButtonOKTapped(credentials: Credentials)
}

protocol LoginPresenterNavigator {
    var onSuccessScreen: (() -> Void)? { get set }
    var onUnauthorized: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
}

class LoginPresenter: LoginPresenterProtocol {
    
    //Properties
    let addServerUsecase: AddServerUsecaseProtocol
    weak var managedView: LoginViewProtocol?
    
    //navigation
    var onSuccessScreen: (() -> Void)?
    var onUnauthorized: (() -> Void)?
    var onError: ((Error) -> Void)?
    var onCancelled: (() -> Void)?
    
    init(addServerUsecase: AddServerUsecaseProtocol) {
        self.addServerUsecase = addServerUsecase
    }
    
    func start() {
        let viewModel = LoginViewModel(placeholderUsername: "Username", placeholderPassword: "Password", buttonTitleOK: "OK", buttonTitleCancel: "Cancel")
        managedView?.updateView(viewModel: viewModel)
    }
    
    func onButtonOKTapped(credentials: Credentials) {
        managedView?.showSpinner()
        
        addServerUsecase.addServer(ipAddress: "", credentials: credentials) {
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
