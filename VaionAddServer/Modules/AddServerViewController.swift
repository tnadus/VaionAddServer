//
//  AddServerViewController.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import UIKit

class AddServerViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var textFieldIPAddress: UITextField!
    @IBOutlet weak var buttonOK: UIButton!
    
    //Properties
    private var presenter: AddServerPresenterProtocol
    
    init(presenter: AddServerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "AddServerViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSubViews()
        presenter.start()
    }
    
    private func updateSubViews() {
        textFieldIPAddress.text = ""
        buttonOK.isEnabled = false
    }
    
    @IBAction func onTextFieldChanged(_ sender: Any) {
        if let text = textFieldIPAddress.text, text.isEmpty == false {
            buttonOK.isEnabled = true
        } else {
            buttonOK.isEnabled = false
        }
    }
    
    @IBAction func onButtonOKTapped(_ sender: Any) {
        guard let text = textFieldIPAddress.text else { return }
        presenter.onOKButtonTapped(ipAddress: text)
    }
}

extension AddServerViewController: AddServerViewProtocol {
    
    func updateView(placeholder: String, buttonTitle: String) {
        textFieldIPAddress.placeholder = placeholder
        buttonOK.setTitle(buttonTitle, for: .normal)
    }
    
    func showSpinner() {
        
    }
    
    func hideSpinner() {
        
    }
    
    
}
