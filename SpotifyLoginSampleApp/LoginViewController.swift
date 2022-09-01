//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by Yongwoo Yoo on 2022/03/22.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
	
	@IBOutlet weak var emailLoginButton: UIButton!
	@IBOutlet weak var googleLoginButton: GIDSignInButton!
	@IBOutlet weak var appleLoginButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		[emailLoginButton,googleLoginButton,appleLoginButton].forEach{
			$0?.layer.borderWidth = 1
			$0?.layer.borderColor = UIColor.white.cgColor
			$0?.layer.cornerRadius = 30
		}
		
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationController?.navigationBar.isHidden = true
		
		//google signin
		GIDSignIn.sharedInstance()?.presentingViewController = self
		
	}
	@IBAction func googleLoginButtonTapped(_ sender: UIButton) {
		//firebase 인증
		GIDSignIn.sharedInstance().signIn()
	}
	@IBAction func appleLoginButtonTapped(_ sender: UIButton) {
		//firebase 인증
	}
}
