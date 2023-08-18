//
//  webViewController.swift
//  Ghibli-movie
//
//  Created by 徐于茹 on 2023/8/19.
//

import UIKit
import WebKit

class webViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.myvideo.net.tw/mainGroup/Group/StudioGhibli/")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
