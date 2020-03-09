//
//  LoginViewController.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private enum Constants {
        static let buttonOKDimmedValue: CGFloat = 0.5
    }
    
    //IBOutlets
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonOK: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Properties
    let presenter: LoginPresenterProtocol
    
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: type(of: self)), bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSubviews()
        presenter.managedView = self
        presenter.start()
    }
    
    private func updateSubviews() {
        textFieldUsername.text = ""
        textFieldPassword.text = ""
        enableButtonOK(enabled: false, dimmed: Constants.buttonOKDimmedValue)
    }
    
    @IBAction func onTextFieldUsernameChanged(_ sender: Any) {
        if let text = textFieldUsername.text, text.isEmpty == false {
            enableButtonOK(enabled: true)
        } else {
            enableButtonOK(enabled: false, dimmed: Constants.buttonOKDimmedValue)
        }
    }
    
    @IBAction func onButtonOKTapped(_ sender: Any) {
        let credentials = Credentials(username: textFieldUsername.text ?? "", password: textFieldPassword.text ?? "")
        presenter.onButtonOKTapped(credentials: credentials)
    }
    
    @IBAction func onButtonCancelTapped(_ sender: Any) {
        presenter.onButtonCancelTapped()
    }
    
    private func enableButtonOK(enabled: Bool, dimmed: CGFloat = 1.0) {
        buttonOK.isEnabled = enabled
        buttonOK.alpha = dimmed
    }
}

extension LoginViewController: LoginViewProtocol {
    
    func updateView(viewModel: LoginViewModel) {
        textFieldUsername.placeholder = viewModel.placeholderUsername
        textFieldPassword.placeholder = viewModel.placeholderPassword
        buttonOK.setTitle(viewModel.buttonTitleOK, for: .normal)
        buttonCancel.setTitle(viewModel.buttonTitleCancel, for: .normal)
    }
    
    func showSpinner() {
        view.isUserInteractionEnabled = false
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        view.isUserInteractionEnabled = true
        spinner.stopAnimating()
    }
    
    func resetCredentials() {
        textFieldUsername.text = ""
        textFieldPassword.text = ""
        enableButtonOK(enabled: false, dimmed: Constants.buttonOKDimmedValue)
        DispatchQueue.main.async { self.textFieldUsername.becomeFirstResponder() }
    }
}
