//
//  LoginViewController.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
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
        super.init(nibName: "LoginViewController", bundle: Bundle.main)
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
        buttonOK.isEnabled = false
    }
    
    @IBAction func onTextFieldUsernameChanged(_ sender: Any) {
        guard let text = textFieldUsername.text, text.isEmpty == false else { return }
        buttonOK.isEnabled = true
    }
    
    @IBAction func onButtonOKTapped(_ sender: Any) {
        let credentials = Credentials(username: textFieldUsername.text ?? "", password: textFieldPassword.text ?? "")
        presenter.onButtonOKTapped(credentials: credentials)
    }
    
    @IBAction func onButtonCancelTapped(_ sender: Any) {
        presenter.onButtonCancelTapped()
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
        DispatchQueue.main.async { self.textFieldUsername.becomeFirstResponder() }
    }
}
