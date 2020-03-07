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
    
    weak var managedView: AddServerViewProtocol?
    
    func start() {
        managedView?.updateView(placeholder: "IP Address", buttonTitle: "OK")
    }
    
}
