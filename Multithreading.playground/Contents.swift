import Foundation
import PlaygroundSupport
import UIKit

class Queue {
    private let serialQueue = DispatchQueue(label: "serialTest")
    private let concurrentQueue = DispatchQueue(label: "cuncurrentTest", attributes: .concurrent)
}

class QueueNew {
    private let globalQueue = DispatchQueue.global()
    private let mainQueue = DispatchQueue.main
}

class MyViewController: UIViewController {
    var button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc 1"
        view.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initButton()
    }
    
    @objc func pressAction() {
        let vc = NewViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.setTitle("Press", for: .normal)
        button.backgroundColor = UIColor.green
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(button)
    }
}

class NewViewController: UIViewController {
        
    var image = UIImageView()
        
        override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc 2"
        view.backgroundColor = UIColor.white
        loadFoto()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initImage()
    }
    
    func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = view.center
        print("s")
        view.addSubview(image)
    }
    
    func loadFoto() {
        let imageURL: URL = URL(string: "https://miro.medium.com/max/2000/1*aXlkAYSD5T48g6KWBS63cg.png")!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.sync {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
}


let vc = MyViewController()
let navbar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navbar

