//
//  AddServerSuccessViewController.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import UIKit

class AddServerSuccessViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
    
    //Properties
    let successInfo: AddServerSuccessInfo
    
    init(successInfo: AddServerSuccessInfo) {
        self.successInfo = successInfo
        super.init(nibName: String(describing: type(of: self)), bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSubviews()
    }
    
    private func updateSubviews() {
        labelTitle.text = successInfo.title
        labelMessage.text = successInfo.message
    }
}
