//
//  AddServerViewController.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import UIKit

class AddServerViewController: UIViewController {
    
    private enum Constants {
        static let buttonOKDimmedValue: CGFloat = 0.5
    }
    
    //IBOutlets
    @IBOutlet weak var textFieldIPAddress: UITextField!
    @IBOutlet weak var buttonOK: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Properties
    private var presenter: AddServerPresenterProtocol
    
    init(presenter: AddServerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: type(of: self)), bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSubViews()
        presenter.managedView = self
        presenter.start()
    }
    
    private func updateSubViews() {
        textFieldIPAddress.text = ""
        enableButtonOK(enabled: false, dimmed: Constants.buttonOKDimmedValue)
    }
    
    @IBAction func onTextFieldChanged(_ sender: Any) {
        if let text = textFieldIPAddress.text, text.isEmpty == false {
            enableButtonOK(enabled: true)
        } else {
            enableButtonOK(enabled: false, dimmed: Constants.buttonOKDimmedValue)
        }
    }
    
    @IBAction func onButtonOKTapped(_ sender: Any) {
        guard let text = textFieldIPAddress.text else { return }
        presenter.onOKButtonTapped(ipAddress: text)
    }
    
    private func enableButtonOK(enabled: Bool, dimmed: CGFloat = 1.0) {
        buttonOK.isEnabled = enabled
        buttonOK.alpha = dimmed
    }
}

extension AddServerViewController: AddServerViewProtocol {
    
    func updateView(placeholder: String, buttonTitle: String) {
        textFieldIPAddress.placeholder = placeholder
        buttonOK.setTitle(buttonTitle, for: .normal)
    }
    
    func showSpinner() {
        self.view.isUserInteractionEnabled = false
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        spinner.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
}
