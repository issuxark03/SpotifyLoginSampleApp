//
//  AppDelegate.swift
//  SpotifyLoginSampleApp
//
//  Created by Yongwoo Yoo on 2022/03/22.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
	//구글로그인후처리
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		//에러발생시
		if let error = error {
			print("ERRor Google Sign in \(error.localizedDescription)")
			return
		}
		
		guard let authentication = user.authentication else { return }
		let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
		
		Auth.auth().signIn(with: credential) { _, _ in
			self.showMainViewController()
		}
	}
	
	private func showMainViewController() {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
		mainViewController.modalPresentationStyle = .fullScreen
		UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
	}
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		//Firebase 초기화
		FirebaseApp.configure()
		
		GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
		GIDSignIn.sharedInstance().delegate = self
		
		// Override point for customization after application launch.
		return true
	}
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		return GIDSignIn.sharedInstance().handle(url)
		
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

