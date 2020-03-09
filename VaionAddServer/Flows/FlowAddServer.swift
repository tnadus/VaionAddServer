//
//  FlowAddServer.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import UIKit

protocol Router {
    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool) -> UIViewController?
}

class FlowAddServer {
    
    //Properties
    let router: Router
    let moduleFactory: ModuleFactory
    
    init(router: Router, moduleFactory: ModuleFactory) {
        self.router = router
        self.moduleFactory = moduleFactory
    }
    
    func start(navCompletion: ((AddServerPresenterNavigatorProtocol) -> Void)? = nil ) {
        let (vc, navigator) = moduleFactory.makeAddServerModule()
        
        navigator.onSuccessScreen = navigateToSuccessScreen
        navigator.onLoginScreen = { [weak self] ipAddress in
            self?.navigateToLoginScreen(ipAddress: ipAddress)
        }
        navigator.onError = showErrorAlert
        
        router.pushViewController(vc, animated: false)
        navCompletion?(navigator)
    }
    
    func navigateToSuccessScreen() {
        let vc = moduleFactory.makeAddServerSuccessModule()
        router.pushViewController(vc, animated: true)
    }
    
    func navigateToLoginScreen(ipAddress: String, navCompletion: ((LoginPresenterNavigatorProtocol) -> Void)? = nil) {
        
        let (vc, navigator) = moduleFactory.makeLoginModule(ipAddress: ipAddress)
        navigator.onSuccessScreen = navigateToSuccessScreen
        navigator.onCancelled = { [weak self] in
            self?.router.popViewController(animated: true)
        }
        router.pushViewController(vc, animated: true)
        navCompletion?(navigator)
    }
    
    func showErrorAlert(error: Error) {
        let title = "Error - \((error as NSError).code)"
        let message = "Unexpected error"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        router.present(alertController, animated: true, completion: nil)
    }
}
