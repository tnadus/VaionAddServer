//
//  AddServerPresenter.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import Foundation

protocol AddServerViewProtocol: class {
    func updateView()
}

protocol AddServerPresenterProtocol {
    
}

class AddServerPresenter: AddServerPresenterProtocol {
    
    weak var managedView: AddServerViewProtocol?
    
    func start() {
        managedView?.updateView()
    }
    
}
