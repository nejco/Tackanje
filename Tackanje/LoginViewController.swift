//
//  ViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 14. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import OAuthSwift


class LoginViewController: UIViewController {
    
    @IBAction func login(sender: UIButton) {
        let oauthswift = OAuth2Swift(
            consumerKey:    "********",
            consumerSecret: "********",
            authorizeUrl:   "https://api.instagram.com/oauth/authorize",
            responseType:   "token"
        )
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "oauth-swift://oauth-callback/instagram")!,
            scope: "likes+comments", state:"INSTAGRAM",
            success: { credential, response, parameters in
                print(credential.oauth_token)
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

