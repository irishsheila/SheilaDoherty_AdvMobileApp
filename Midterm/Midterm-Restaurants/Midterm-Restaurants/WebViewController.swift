//
//  WebViewController.swift
//  Midterm-Restaurants
//
//  Created by Sheila Doherty on 3/15/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    var webpage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        loadWebPage()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadWebPage(){
        guard let weburl = webpage
            else{
                print("no webpage found")
                return
            }
        let url = URL(string:weburl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        webSpinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webSpinner.stopAnimating()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
