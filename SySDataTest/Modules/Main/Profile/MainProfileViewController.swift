//
//  ProfileViewController.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import UIKit
import MessageUI

class MainProfileViewController: BaseViewController {
    
    var viewModel: MainProfileViewModelProtocol
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    init(viewModel: MainProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: MainProfileViewController.className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInformation()
        setupAvatarContainer()
    }
    
    private func setupAvatarContainer() {
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    func setUserInformation() {
        nameLabel.text = viewModel.getName()
        addressLabel.text = viewModel.getLocation()
        avatarImageView.sd_setImage(with: URL(string: viewModel.getAvatarPath()), completed: nil)
    }
    
    @IBAction func onSendTapped(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([viewModel.getMail()])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            // ...
        }
    }
    
    @IBAction func onCallTapped(_ sender: Any) {
        guard let number = URL(string: "tel://" + viewModel.getPhone()) else { return }
        UIApplication.shared.open(number)
    }
}

extension MainProfileViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
