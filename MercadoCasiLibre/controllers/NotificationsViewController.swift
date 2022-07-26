//
//  NotificationsViewController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import UIKit
import AppAuth

let clientId = "8070448519337069"
let clientSecret = "URUxoV4cedbUqaXvKq8dcDrVNNBRGHkZ"
let redirectURI = URL(string: "https://victorchirino.com/api/mercado-casi-libre/callback")!
//let redirectURI = URL(string: "https://bed0-181-231-238-14.ngrok.io/api/mercado-casi-libre/callback")!
let authorizationEndpoint = URL(string: "https://auth.mercadolibre.com.ar/authorization")!
let tokenEndpoint = URL(string: "https://api.mercadolibre.com/oauth/token")!
let configuration = OIDServiceConfiguration(authorizationEndpoint: authorizationEndpoint,
                                            tokenEndpoint: tokenEndpoint)

class NotificationsViewController: UIViewController {
    
    private lazy var loginEmptyStateView: LoginEmptyStateView = {
        let view = LoginEmptyStateView()
        view.delegate = self
        view.configure(type: .notification)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(loginEmptyStateView)
        
        loginEmptyStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private var authState: OIDAuthState?

    func setAuthState(_ authState: OIDAuthState?) {
        if (self.authState == authState) {
            return;
        }
        self.authState = authState;
        self.saveState()
    }

    func saveState() {
        var data: Data? = nil
        if let authState = self.authState {
            do {
                data = try NSKeyedArchiver.archivedData(withRootObject: authState, requiringSecureCoding: true)
            } catch {
                assertionFailure("Fail to decode item for keychain: \(error)")
            }
        }
        UserDefaults.standard.set(data, forKey: "authState")
        UserDefaults.standard.synchronize()
    }
}

extension NotificationsViewController: LoginEmptyStateViewDelegate {
    func loginEmptyStateLoginButtonTapped() {
        let configuration = OIDServiceConfiguration(authorizationEndpoint: authorizationEndpoint,
                                                    tokenEndpoint: tokenEndpoint,
                                                    issuer: nil)
        let request = OIDAuthorizationRequest(configuration: configuration,
                                              clientId: clientId,
                                              clientSecret: nil,
                                              scopes: [OIDScopeOpenID, OIDScopeProfile],
                                              redirectURL: redirectURI,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: nil)
        print("Initiating authorization request with scope: \(request.scope ?? "nil")")
        
        guard let scene = UIApplication.shared.connectedScenes.first, let windowSceneDelegate = scene.delegate as? SceneDelegate else {
            return
        }
        
        windowSceneDelegate.currentAuthorizationFlow =
            OIDAuthState.authState(byPresenting: request, presenting: self) { authState, error in
          if let authState = authState {
            self.setAuthState(authState)
            print("Got authorization tokens. Access token: " +
                  "\(authState.lastTokenResponse?.accessToken ?? "nil")")
          } else {
            print("Authorization error: \(error?.localizedDescription ?? "Unknown error")")
            self.setAuthState(nil)
          }
        }

    }
}
