//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by Yongwoo Yoo on 2022/03/22.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {

	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var errorMessageLabel: UILabel!
	@IBOutlet weak var nextButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		nextButton.layer.cornerRadius = 30
		nextButton.isEnabled = false
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		emailTextField.becomeFirstResponder() //최초 커서위치
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationController?.navigationBar.isHidden = false
	//	self.navigationItem.title.
	}
    

	@IBAction func nextButtonTapped(_ sender: UIButton) {
		//Firebase 이메일/비밀번호 인증
		let email = self.emailTextField.text ?? ""
		let password = self.passwordTextField.text ?? ""
		
		//신규 사용자 생성
		Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
			guard let self = self else { return }
			
			if let error = error { //에러가존재(옵셔널벗기기)
				let code = (error as NSError).code
				
				switch code {
				case 17007: //이미가입한계정일때
					self.loginUser(withEmail: email, password: password)//로그인하기
				default:
					self.errorMessageLabel.text = error.localizedDescription
				}
			} else {
				self.showMainViewController()
			}
		}
		
	}
	
	private func showMainViewController() {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
		mainViewController.modalPresentationStyle = .fullScreen
		navigationController?.show(mainViewController, sender: nil)
	}
	
	private func loginUser(withEmail email:String, password: String) {
		Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
			guard let self = self else { return }
			
			if let error = error {
				self.errorMessageLabel.text = error.localizedDescription
			} else {
				self.showMainViewController()
			}
		}
	}
	
}

extension EnterEmailViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		view.endEditing(true)
		return false
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		let isEmailEmpty = emailTextField.text == ""
		let isPasswordEmpty = passwordTextField.text == ""
		
		nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty //넥스트버튼 활성화
	}
}
